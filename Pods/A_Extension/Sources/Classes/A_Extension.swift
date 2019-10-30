//
//  A_Extension.swift
//  A_Extension
//
//  Created by zowell on 2019/10/29.
//  Copyright © 2019 Chancc. All rights reserved.
//

import CTMediator

public extension CTMediator {
    @objc func moduleShow(callback: @escaping (String) -> Void) -> UIViewController? {
        let parameters = ["callback": callback, kCTMediatorParamsKeySwiftTargetModuleName: "A_Swift"] as [AnyHashable: Any]
        return performTarget("A", action: "Extension_ViewController", params: parameters, shouldCacheTarget: false) as? UIViewController
    }
}




