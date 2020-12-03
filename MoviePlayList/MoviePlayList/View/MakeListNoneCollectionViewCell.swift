//
//  MakeListNoneCollectionViewCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/03.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MakeListNoneCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MakeListNoneCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "영화를 검색해 주세요."
        label.tintColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
