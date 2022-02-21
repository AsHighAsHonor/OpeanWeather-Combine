//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let ctrl = OneCallWeatherViewController.initFromStoryboard()
        ctrl.viewModel = OneCallWeatherViewModel()
        window?.rootViewController = ctrl
        window?.makeKeyAndVisible()
        return true
    }
}
