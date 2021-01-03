//
//  CustomMainNaviView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class CustomMainNaviView: UIView {
    
    init(title: String, button: UIButton) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        let mainTitle = UILabel()
        mainTitle.text = "\(title)"
        mainTitle.font = UIFont.boldSystemFont(ofSize: 35)
        mainTitle.textColor = .black
        addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        addSubview(button)
        button.snp.makeConstraints {
            $0.centerY.equalTo(mainTitle.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
