//
//  AppDelegate.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.tintColor = #colorLiteral(red: 0.4588235294, green: 0.2509803922, blue: 0.9333333333, alpha: 1)
        return true
    }

}
