//
//  ViewController.swift
//  MyModule
//
//  Created by zowell on 2019/10/29.
//  Copyright © 2019 Chancc. All rights reserved.
//

import UIKit
import A_Extension
import CTMediator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let vc = CTMediator.sharedInstance()?.moduleShow(callback: { (result) in
            print(result)
        }) {
            present(vc, animated: true, completion: nil)
        }
    }


}

