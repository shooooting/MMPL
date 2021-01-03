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
    private let titleLabel = UILabel()
    private let centerTitle = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI() {
        [titleLabel, centerTitle].forEach {
            addSubview($0)
        }
        backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        centerTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func mainConfigure(with title: String, font: UIFont) {
        titleLabel.text = title
        titleLabel.font = font
    }
    
    func profileConfigure(with title: String, font: UIFont) {
        centerTitle.text = title
        centerTitle.font = font
    }
}
