//
//  CALayerExtension.swift
//  MyModule
//
//  Created by zowell on 2020/5/8.
//  Copyright © 2020 Chancc. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    /// 设置边线颜色
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
    
    /// view 影阴
    var shadowUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.shadowColor!)
        }
    }
    
}
