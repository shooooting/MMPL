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

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let main = UINavigationController(rootViewController: MainViewController())
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = main
    window?.makeKeyAndVisible()
  }
}

