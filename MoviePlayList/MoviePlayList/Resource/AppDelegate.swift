//
//  AppDelegate.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let tabBar = UITabBarController()
    let main = UINavigationController(rootViewController: MainViewController())
    let search = UINavigationController(rootViewController: MakeListViewController())
    let third = UINavigationController(rootViewController: ThirdViewController())
    
    main.tabBarItem = UITabBarItem(title: "L:)st", image: UIImage(systemName: "film"), tag: 0)
    search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
    third.tabBarItem = UITabBarItem(title: "choose", image: UIImage(systemName: "list.bullet"), tag: 2)
    
    UITabBar.appearance().backgroundColor = UIColor.white
    UITabBar.appearance().tintColor = .black
    tabBar.viewControllers = [main, search, third]
    
    window?.rootViewController = tabBar
    window?.makeKeyAndVisible()
    
    return true
  }
}

