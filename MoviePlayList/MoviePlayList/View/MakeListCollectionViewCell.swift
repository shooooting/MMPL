//
//  MainCollectionViewCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MakeListCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "MakeListCollectionViewCell"
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "나만의 리스트를 만들어 보세요."
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setButton() {
    self.addSubview(label)
    self.layer.cornerRadius = 10
    self.backgroundColor = .systemGray6
    label.snp.makeConstraints {
      $0.centerX.equalTo(self.snp.centerX)
      $0.centerY.equalTo(self.snp.centerY)
    }
  }
  
}
