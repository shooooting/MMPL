//
//  PersonButton.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class NaviButton: UIButton {
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        
        setBackgroundImage(image, for: .normal)
        layer.masksToBounds = true
        tintColor = .black
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
