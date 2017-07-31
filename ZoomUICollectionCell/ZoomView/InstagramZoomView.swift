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
    }
    
    func showAt(_ frame : CGRect, _ image : UIImage?, handler complete:(()->())? = nil) {
        self.ivAvatar.frame = frame
        self.ivAvatar.image = image
        let appDelagete = UIApplication.shared.delegate as! AppDelegate
        self.frame = CGRect.init(x: 0, y: 0, width: (appDelagete.window?.bounds.size.width)!, height: (appDelagete.window?.bounds.size.height)!)
        appDelagete.window?.addSubview(self)
        
        complete?()
    }
    
    func zoomWith(_ scale : CGFloat) {
        let zoomTranform = self.ivAvatar.transform.scaledBy(x: scale, y: scale)
        self.ivAvatar.transform = zoomTranform
        self.backgroundColor = UIColor.black.withAlphaComponent(abs(alpha - 1))
    }
    
    func  moveByDistance(_ x:CGFloat, _ y : CGFloat) {
        var center = self.ivAvatar.center
        center.x = center.x + x
        center.y = center.y + y
         self.ivAvatar.center = center
    }
    
    func hiden(_ complete:(()->())? = nil) {
        self.removeFromSuperview()
        if complete != nil {
            complete!()
        }
    }
}
