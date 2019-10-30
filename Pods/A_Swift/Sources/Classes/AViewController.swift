//
//  AViewController.swift
//  A_Swift
//
//  Created by zowell on 2019/10/29.
//  Copyright © 2019 Chancc. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    
    var buttonBlue: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.frame = CGRect(x: 100, y: 200, width: 80, height: 80)
        button.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        return button
    }()
    
    var buttonYellow: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 188, y: 200, width: 80, height: 80)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(dismissPresent), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        view.addSubview(buttonBlue)
        view.addSubview(buttonYellow)
    }
    

    @objc func didClick() {
        present(BViewController(), animated: true, completion: nil)
    }
    
    @objc func dismissPresent() {
        dismiss(animated: true, completion: nil)
    }
    

}
