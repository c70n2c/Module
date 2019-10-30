//
//  Target_A.swift
//  A_Swift
//
//  Created by zowell on 2019/10/29.
//  Copyright © 2019 Chancc. All rights reserved.
//

import UIKit


// 对应A_Extension
/*
 let params = [
            "callback":callback,
            kCTMediatorParamsKeySwiftTargetModuleName:"A_swift"
            ] as [AnyHashable : Any]
        if let viewController = self.performTarget("A", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil

*/


@objc class Target_A: NSObject {
    
    
    /// kCTMediatorParamsKeySwiftTargetModuleName: "A_Swift"
    /// - Parameter parameters: <#parameters description#>
    @objc func Action_Extension_ViewController(_ parameters: NSDictionary) -> UIViewController {
        if let callback = parameters["callback"] as? (String) -> Void {
            callback("Success !!! -- Target_A")
        }
        let vc = AViewController()
        return vc
    }
}
