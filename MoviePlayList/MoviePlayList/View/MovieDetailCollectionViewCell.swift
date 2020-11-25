//
//  MovieDetailCollectionViewCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieDetailCollectionViewCell"
    
    private let upViewTitle = UILabel()
    let backBtn = UIButton()
    
    private let view = UIImageView()
    
    private let img: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private let titleLabel = UILabel()
    let moreButton = UIButton()
    private let subTitleLabel = UILabel()
    private let date = UILabel()
    
    private let directorTitle = UILabel()
    private let director = UILabel()
    
    private let actorTitle = UILabel()
    private let actor = UILabel()
    
    private let rating = UIView()
    private let ratingScore = UILabel()
    
    let addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        contentView.backgroundColor = .systemBackground
        [backBtn, upViewTitle, view, img, titleLabel, subTitleLabel, date, directorTitle, director, actorTitle, actor, rating, ratingScore, moreButton, addButton].forEach { contentView.addSubview($0) }
        
        let sfImg = UIImage(systemName: "arrow.left")
        backBtn.setImage(sfImg, for: .normal)
        backBtn.tintColor = UIColor.black
        backBtn.sizeToFit()
        
        moreButton.setTitle("더보기", for: .normal)
        moreButton.setTitleColor(.white, for: .normal)
        moreButton.backgroundColor = .black
        
        view.backgroundColor = .black
        
        upViewTitle.text = "PickMov:)e"
        
        upViewTitle.font = UIFont(name: "AppleSDGothicNeo-bold", size: 35)
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-bold", size: 25)
        subTitleLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)
        subTitleLabel.sizeToFit()
        
        date.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        
        directorTitle.text = "Director"
        directorTitle.font = UIFont(name: "AppleSDGothicNeo-bold", size: 20)
        directorTitle.textColor = .black
        
        director.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        
        actorTitle.text = "Actor"
        actorTitle.font = UIFont(name: "AppleSDGothicNeo-bold", size: 20)
        actorTitle.textColor = .black
        
        actor.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)
        actor.numberOfLines = 0
        
        rating.backgroundColor = .black
        ratingScore.font = UIFont(name: "AppleSDGothicNeo-bold", size: 40)
        ratingScore.textColor = .white
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .black
        
        backBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(upViewTitle.snp.leading)
            $0.bottom.equalTo(upViewTitle.snp.top)
        }
        
        upViewTitle.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom)
            $0.height.equalTo(70)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalTo(view.snp.top)
        }
        
        view.snp.makeConstraints {
            $0.top.equalTo(upViewTitle.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        img.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.bottom)
        }
        
        rating.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        ratingScore.snp.makeConstraints {
            $0.centerX.equalTo(rating.snp.centerX)
            $0.centerY.equalTo(rating.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(rating.snp.bottom).offset(25)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(moreButton.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }
        
        date.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
        }
        
        directorTitle.snp.makeConstraints {
            $0.top.equalTo(date.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
        }
        
        director.snp.makeConstraints {
            $0.top.equalTo(directorTitle.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
        }
        
        actorTitle.snp.makeConstraints {
            $0.top.equalTo(director.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
        }
        
        actor.snp.makeConstraints {
            $0.top.equalTo(actorTitle.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(actor.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(contentView.snp.width)
            $0.height.equalTo(30)
        }
    }
    
    func configure(image: UIImage, title: String, subTitle: String, pubDate: String, dirString: String, actString: String, ratingString: String) {
        img.image = image
        titleLabel.text = title
        subTitleLabel.text = subTitle
        date.text = "(\(pubDate))"
        director.text = dirString
        actor.text = actString
        ratingScore.text = ratingString
    }
}
