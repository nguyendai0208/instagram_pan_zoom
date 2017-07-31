//
//  ViewController.swift
//  ZoomUICollectionCell
//
//  Created by Neo Nguyen on 7/30/17.
//  Copyright © 2017 Neo Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var numberItemInRow = 1
    @IBOutlet weak var colImages : UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.colImages.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:
    func performBeginZoomImage(_ iv : UIImageView){
        let frame = iv.convert(iv.frame, to: nil)
        print(frame)
        
//        let ivPic = UIImageView.init(frame: frame)
//        ivPic.backgroundColor = UIColor.red
//        ivPic.isUserInteractionEnabled = true
//        appDelegate.window?.addSubview(ivPic)
        
//        self.instagramZoom = InstagramZoomView.instance
//        self.instagramZoom?.showAt(frame, #imageLiteral(resourceName: "danbo"))
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberItemInRow*10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        cell.controller = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * CGFloat(self.numberItemInRow - 1))
        
        let width = (collectionView.bounds.width - totalSpace)/CGFloat(self.numberItemInRow)
        let size = CGSize.init(width: width, height: width)
        return size
    }
}
