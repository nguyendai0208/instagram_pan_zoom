//
//  InstagramZoomView.swift
//  ZoomUICollectionCell
//
//  Created by Neo Nguyen on 7/30/17.
//  Copyright © 2017 Neo Nguyen. All rights reserved.
//

import UIKit

class InstagramZoomView: UIView {
    
    static let instance : InstagramZoomView = Bundle.main.loadNibNamed("InstagramZoomView", owner: nil, options: nil)?.first as! InstagramZoomView
    
    @IBOutlet weak var scrollMain : UIScrollView!
    @IBOutlet weak var ivAvatar : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivAvatar.isUserInteractionEnabled = true
        
        self.scrollMain.maximumZoomScale = 6.0
        self.scrollMain.minimumZoomScale = 1.0
        self.scrollMain.delegate = self
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handlPan(_:)))
        self.ivAvatar.addGestureRecognizer(panGesture)
        
    }
    
    func handlPan(_ panGesture : UIPanGestureRecognizer){
        print("panges \(panGesture.location(in: self.ivAvatar.superview))")
        self.ivAvatar.center = panGesture.location(in: self.ivAvatar.superview)
    }
    
    func showAt(_ frame : CGRect, _ image : UIImage?) {
        self.ivAvatar.frame = frame
        self.scrollMain.contentSize = frame.size
//        self.ivAvatar.image = image
        let appDelagete = UIApplication.shared.delegate as! AppDelegate
        self.frame = CGRect.init(x: 0, y: 0, width: (appDelagete.window?.bounds.size.width)!, height: (appDelagete.window?.bounds.size.height)!)
        appDelagete.window?.addSubview(self)
    }
    
    func zoomWith(_ scale : CGFloat) {
        self.scrollMain.zoomScale = scale
    }
    
    func moveToView(_ center : CGPoint) {
        print("Center : \(center)")
        self.ivAvatar.center = center
    }
    
    func hiden() {
        self.removeFromSuperview()
    }
}
extension InstagramZoomView : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.ivAvatar
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("instagram endDragging")
//        self.hiden()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("instagram scrollViewDidEndScrollingAnimation")
    }
}
