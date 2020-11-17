//
//  SceneDelegate.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let tabBar = UITabBarController()
    let main = UINavigationController(rootViewController: MainViewController())
    let search = MakeListViewController()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    main.tabBarItem = UITabBarItem(title: "L:)st", image: UIImage(systemName: "film"), tag: 0)
    search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
    
    UITabBar.appearance().backgroundColor = UIColor.white
    UITabBar.appearance().tintColor = .black
    tabBar.viewControllers = [main, search]
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = tabBar
    window?.makeKeyAndVisible()
  }
}

