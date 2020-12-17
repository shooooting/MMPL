//
//  InputContainerView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/17.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class InputContainerView: UIView {
    
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        
        let imgV = UIImageView()
        imgV.image = image
        imgV.tintColor = .black
        imgV.alpha = 0.7
        
        addSubview(imgV)
        imgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.height.width.equalTo(24)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imgV.snp.trailing).offset(8)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let underLine = UIView()
        underLine.backgroundColor = .black
        addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0.7)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
