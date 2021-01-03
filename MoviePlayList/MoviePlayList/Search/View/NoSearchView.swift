//
//  NoSearchView.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class NoSearchView: UIView {
    
    // MARK: - Properties
    let title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textAlignment = .center
        return title
    }()
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        self.title.text = title
        self.isHidden = true
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }
    
    private func setPropertyAttributes() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .black
    }
    
    private func setConstraints() {
        self.addSubview(title)
        self.title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

