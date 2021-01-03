//
//  AddMovieCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class AddMovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "AddMovieCell"
    
    var review: Review? {
        didSet { configure() }
    }
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Some test message for now..."
        return tv
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualTo(250)
        }
        
        container.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let review = review else { return }
        
        textView.text = review.text
    }
}
