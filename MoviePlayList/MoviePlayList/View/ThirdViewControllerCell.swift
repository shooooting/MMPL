//
//  ThirdCollectionViewCell.swift
//  MakeNavi
//
//  Created by ㅇ오ㅇ on 2020/08/03.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "ThirdCollectionViewCell"
  
  let button = UILabel()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setConstraint()
  }
  
  private func setUI() {
    contentView.addSubview(button)
    button.font = .boldSystemFont(ofSize: 20)
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    button.textColor = .black
    button.textAlignment = .center
  }
  
  private func setConstraint() {
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      button.widthAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  func configure(title: String) {
    button.text = title
  }
}
