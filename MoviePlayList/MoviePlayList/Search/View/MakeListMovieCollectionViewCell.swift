//
//  MakeListMovieCollectionViewCell.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import SnapKit

class MakeListMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MakeListMovieCollectionViewCell"
    
    var movieInfo: MovieInfo? {
        didSet {
            configure()
        }
    }
    
    private let img: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.sizeToFit()
        return image
    }()
    
    private var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.backgroundColor = .darkGray
        title.alpha = 0.9
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        img.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        contentView.addSubview(img)
        contentView.backgroundColor = .quaternaryLabel
        img.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        img.addSubview(title)

    }
    
    func configure() {
        guard let image = movieInfo?.image else { return }
        guard let title = movieInfo?.title else { return }
        
        if image == "" {
            img.image = UIImage(named: "noposter")
        } else {
            img.kf.setImage(with: URL(string: image))
        }
        
        let estimatedSizeCell = self.title
        estimatedSizeCell.text = title.stringChange()
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: contentView.frame.width, height: 100)
        let size = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        self.title.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
        }
    }
}
