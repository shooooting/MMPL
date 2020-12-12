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
        image.contentMode = .scaleAspectFill
        image.sizeToFit()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        img.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        [img].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .systemGray
        
        img.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func configure(item: String) {
        if item == "" {
            img.image = UIImage(named: "noposter")
        } else {
            img.kf.setImage(with: URL(string: item))
        }
        
    }
}
