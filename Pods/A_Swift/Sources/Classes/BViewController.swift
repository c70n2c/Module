//
//  BViewController.swift
//  A_Swift
//
//  Created by zowell on 2019/10/30.
//  Copyright © 2019 Chancc. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
