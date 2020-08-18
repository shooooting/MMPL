//
//  LinkViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/15.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import WebKit

class LinkViewController: UIViewController, WKUIDelegate {
  
  private let upV: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  
  var upViewTitle = UILabel()
  private var web: WKWebView!
  var url: String = ""
  
  private let xButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setWeb()
    setConstraint()
    requestURL(url: url)
  }
  
  private func setWeb() {
    let webConfigure = WKWebViewConfiguration()
    web = WKWebView(frame: .zero, configuration: webConfigure)
    web.uiDelegate = self
  }
  
  private func setConstraint() {
    guard let web = web else { return }
    [web, xButton, upV, upViewTitle].forEach { view.addSubview($0) }
    upViewTitle.font = UIFont(name: "AppleSDGothicNeo-bold", size: 35)
    xButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    xButton.tintColor = .black
    xButton.addTarget(self, action: #selector(tapBackButton(_:)), for: .touchUpInside)
    web.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    xButton.snp.makeConstraints {
      $0.top.equalTo(16)
      $0.trailing.equalTo(-16)
    }
    upV.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.16)
    }
    upViewTitle.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(8)
      $0.bottom.equalTo(upV.snp.bottom).inset(16)
    }
  }
  
  @objc func tapBackButton(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  private func requestURL(url: String) {
    guard let goURL = URL(string: url) else { return }
    let request = URLRequest(url: goURL)
    web.load(request)
  }
}
