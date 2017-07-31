//
//  ImageCell.swift
//  ZoomUICollectionCell
//
//  Created by Neo Nguyen on 7/30/17.
//  Copyright © 2017 Neo Nguyen. All rights reserved.
//

import UIKit

@objc protocol ImageCellDelegate : NSObjectProtocol {
    @objc optional func ImageCell_BeginZoom(_ cell : ImageCell)
    @objc optional func ImageCell_EndZoom(_ cell : ImageCell)
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak fileprivate var scrollMain : UIScrollView!
    
    @IBOutlet weak fileprivate var ivAvatar : UIImageView!
    var delegate  : ImageCellDelegate?
    
    fileprivate var imgContent : UIImage?{
        didSet{
            if imgContent != nil {
                self.ivAvatar.image = nil
            }
        }
    }
    
    fileprivate var instagramZoom : InstagramZoomView?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.ivAvatar.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        panGesture.delegate = self
        self.ivAvatar.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
        
        let gesture = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchZoom(_:)))
        gesture.delegate = self
        self.ivAvatar.addGestureRecognizer(gesture)
        gesture.cancelsTouchesInView = false
    }
    
    fileprivate func beginGesture(_ gesture : UIGestureRecognizer){
        if self.instagramZoom != nil{
            self.endGesture()
        }
        if let iv = gesture.view as? UIImageView {
            self.instagramZoom = InstagramZoomView.instance
            let frame = iv.convert(iv.frame, to: appDelegate.window)
            self.instagramZoom?.showAt(frame, iv.image)
            
            self.imgContent = iv.image
        }
        if self.delegate != nil &&
            self.delegate!.responds(to: #selector(ImageCellDelegate.ImageCell_BeginZoom(_:))){
            self.delegate!.ImageCell_BeginZoom!(self)
        }
    }
    
    fileprivate func endGesture(){
        if self.instagramZoom != nil{
            self.instagramZoom?.hiden()
            self.instagramZoom = nil
            
            self.ivAvatar.image = self.imgContent
            self.imgContent = nil
            
        }
        if self.delegate != nil &&
            self.delegate!.responds(to: #selector(ImageCellDelegate.ImageCell_EndZoom(_:))){
            self.delegate!.ImageCell_EndZoom!(self)
        }
    }

    //MAR: Pinch gesture
    func pinchZoom(_ gesture : UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.beginGesture(gesture)
            break
            
        case .changed:
            
            let currentScale : CGFloat = gesture.view?.layer.value(forKeyPath: "transform.scale.x") as! CGFloat
            let minScale : CGFloat = 0.5
            let maxScale : CGFloat = 5.0
            let zoomSpeed : CGFloat = 0.5
            
            var deltaScale = gesture.scale
            
            deltaScale = (deltaScale - 1)*zoomSpeed + 1
            deltaScale = min(deltaScale, maxScale/currentScale)
            deltaScale = max(deltaScale, minScale / currentScale)
            
            self.instagramZoom?.zoomWith(deltaScale)
            gesture.scale = 1
            break
            
        case .ended:
            self.endGesture()
            break
        default:
            break
        }
    }
    func panGesture(_ panGestuge : UIPanGestureRecognizer) {
        switch panGestuge.state {
        case .began:
            break
            
        case .changed:
            let view = panGestuge.view!
            
            let translation = panGestuge.translation(in: view.superview)
            self.instagramZoom?.moveByDistance(translation.x , translation.y)
            panGestuge.setTranslation(CGPoint.zero, in: self)
            break
            
        case .ended:
            self.endGesture()
            break
        default:
            break
        }
    }
}

extension ImageCell : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
