//
//  Extentions.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/30.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

extension UIViewController {
    static let indicate = UIActivityIndicatorView()
    static let indicateView: UIView = {
        let indi = UIView()
        let indicate = UIViewController.indicate
        indicate.hidesWhenStopped = true
        indicate.style = .large
        indicate.color = .white

        indi.addSubview(indicate)
        indicate.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.center.equalToSuperview()
        }

        indi.isHidden = true
        indi.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return indi
    }()

    func showIndicate() {
        self.view.addSubview(UIViewController.indicateView)
        UIViewController.indicateView.isHidden = false
        UIViewController.indicateView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        UIViewController.indicate.startAnimating()
    }

    func stopIndicate() {
        UIViewController.indicateView.isHidden = true
        UIViewController.indicate.stopAnimating()
    }

}
