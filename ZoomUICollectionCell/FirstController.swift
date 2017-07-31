//
//  FirstController.swift
//  ZoomUICollectionCell
//
//  Created by DAI NGUYEN on 7/31/17.
//  Copyright © 2017 Neo Nguyen. All rights reserved.
//

import UIKit

class FirstController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func click_next(_ sender : UIButton?){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }

}
