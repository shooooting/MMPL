//
//  MainTitleView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/10/18.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MainTitleView: UIView {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI() {
        [titleLabel].forEach {
            addSubview($0)
        }
        backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
    }
    
    private func setConstraints() {
        titleLabel.text = "PlayL:)st"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
    }
}
