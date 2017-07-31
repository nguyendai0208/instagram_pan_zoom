//
//  ImageCell.swift
//  ZoomUICollectionCell
//
//  Created by Neo Nguyen on 7/30/17.
//  Copyright © 2017 Neo Nguyen. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak fileprivate var scrollMain : UIScrollView!
    
    @IBOutlet weak fileprivate var ivAvatar : UIImageView!
    var controller : ViewController?
    
    fileprivate var instagramZoom : InstagramZoomView?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.ivAvatar.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        panGesture.cancelsTouchesInView = false
        panGesture.delegate = self
        self.ivAvatar.addGestureRecognizer(panGesture)
        
        let gesture = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchZoom(_:)))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        self.ivAvatar.addGestureRecognizer(gesture)
    }

    //MAR: Pinch gesture
    func pinchZoom(_ gesture : UIPinchGestureRecognizer) {
        print("zoom image")
        if let ivZoom = gesture.view as? UIImageView{
            switch gesture.state {
            case .possible:
                print("possible zoom")
                break
                
            case .failed:
                print("failt zoom")
                break
                
            case .began:
                print("Begin zoom")
                break
                
            case .changed:
                print("Change \(gesture.scale)")
                self.instagramZoom?.zoomWith(gesture.scale)
                break
                
            case .ended:
                print("End zoom")
                self.instagramZoom?.hiden()
                self.instagramZoom = nil
                break
                
                
            default:
                break
            }
        }
    }
    func panGesture(_ panGestuge : UIPanGestureRecognizer) {
        if let instagram = self.instagramZoom{
            let view = panGestuge.view!
            let translation = panGestuge.translation(in: view.superview)
            
            let point = CGPoint.init(x: view.center.x + translation.x, y: view.center.y + translation.y)
            instagram.moveToView(point)
            
            switch panGestuge.state {
            case .began:
                print("pan begin")
                break
                
            case .ended:
                print("pan end")
                instagram.hiden()
                break
                
            case .changed:
                print("pan change")
                break
            default:
                break
            }
        }
    }
}

extension ImageCell : UIGestureRecognizerDelegate{
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let ivZoom = gestureRecognizer.view as? UIImageView {
            let frame = ivZoom.convert(ivZoom.frame, to: nil)
            self.instagramZoom = InstagramZoomView.instance
            self.instagramZoom?.showAt(frame, ivZoom.image)
        }
        
        return true
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Move")
    }
}

extension ImageCell : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.controller?.performBeginZoomImage(self.ivAvatar)
    }
}
