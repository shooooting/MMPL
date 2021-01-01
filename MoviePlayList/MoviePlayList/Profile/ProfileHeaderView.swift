//
//  ProfileHeaderView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/01.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profilePhotoButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        
        
        addSubview(profilePhotoButton)
        
        profilePhotoButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
