//
//  MakeListMovieCollectionViewCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import SnapKit

class MakeListMovieCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "MakeListMovieCollectionViewCell"
  
  let img: UIImageView = {
    let image = UIImageView()
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    constraintUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func constraintUI() {
    [img].forEach { contentView.addSubview($0) }
    
    img.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }

  }
  
  func configure(item: UIImage) {
    img.image = item
  }
}
