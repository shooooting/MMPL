//
//  AddMovieNaviView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class AddMovieNaviView: UIView {
    
    init(title: String, movieName: String, posterButton: UIButton, backButton: UIButton) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        let mainTitle = UILabel()
        mainTitle.text = "\(title)"
        mainTitle.font = UIFont.boldSystemFont(ofSize: 35)
        mainTitle.textColor = .black
        
        let movieTitle = UILabel()
        movieTitle.text = "\(movieName)"
        movieTitle.font = .systemFont(ofSize: 16)
        movieTitle.textColor = .black
        
        [mainTitle, backButton, posterButton, movieTitle].forEach {
            addSubview($0)
        }
        
        posterButton.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.equalTo(60)
            $0.height.equalTo(80)
        }
        
        mainTitle.snp.makeConstraints {
            $0.leading.equalTo(posterButton.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
        }
        
        movieTitle.snp.makeConstraints {
            $0.leading.equalTo(posterButton.snp.trailing).offset(8)
            $0.bottom.equalTo(mainTitle.snp.top).offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

