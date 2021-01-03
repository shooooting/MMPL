//
//  MovieSearchTextField.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class MovieSearchTextField: UITextField {
    
    private let border = CALayer()
    
    init() {
        super.init(frame: .zero)
        
        borderStyle = .none
        textColor = UIColor.black
        placeholder = "검색어를 입력해주세요."
        
        layer.addSublayer(border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 2)
        border.backgroundColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
