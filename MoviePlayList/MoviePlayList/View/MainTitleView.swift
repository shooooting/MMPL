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
    let subLabel = UILabel()
    
    
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
        [titleLabel, subLabel].forEach {
            addSubview($0)
        }
        backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    private func setConstraints() {
        titleLabel.text = "PlayL:)st"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        subLabel.text = "나만의 후기를 만들어 보세요."
    }
}
