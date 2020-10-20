//
//  AddReviewButton.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/10/19.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class AddReviewButton: UIButton {
    
    // MARK: - Properties
    private var style: ButtonStyle = .white
    var isActive = true {
        didSet {
            configureButtonStatus()
        }
    }
    
    
    // MARK: - Lifecycle
    init(title: String, style: ButtonStyle) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.style = style
        self.setColors(style: style)
        setPropertyAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - setUI
    private func setPropertyAttributes() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
    private func setColors(style: ButtonStyle) {
        switch style {
        case .black:
            self.backgroundColor = UIColor.black
            self.setTitleColor(.white, for: .normal)
        case .white:
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
        }
    }
    
    private func configureButtonStatus() {
        switch isActive {
        case true:
            setColors(style: style)
        case false:
            self.backgroundColor = .black
            self.layer.borderColor = UIColor.black.cgColor
            self.setTitleColor(.white, for: .normal)
        }
    }
}

extension AddReviewButton {
    
    enum ButtonStyle {
        case black
        case white
    }
}
