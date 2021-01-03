//
//  CustomBackNaviView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class CustomBackNaviView: UIView {
    
    init(title: String, backButton: UIButton) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        let mainTitle = UILabel()
        mainTitle.text = "\(title)"
        mainTitle.font = UIFont.boldSystemFont(ofSize: 35)
        mainTitle.textColor = .black
        
        [mainTitle, backButton].forEach {
            addSubview($0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
