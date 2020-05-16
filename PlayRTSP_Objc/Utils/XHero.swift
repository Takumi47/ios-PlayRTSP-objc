//
//  XHero.swift
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

import Hero

@objcMembers public class XHero: NSObject {

    public static func finishTransition() {
        Hero.shared.finish()
    }
    
    public static func dismiss(_ viewController: UIViewController, with completion: (() -> Void)?) {
        viewController.hero.dismissViewController(completion: completion)
    }
}
