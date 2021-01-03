//
//  MovieDetailViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properitse
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(frame: .zero,
                                                    collectionViewLayout: layout)
    
    var detailData: [MovieInfo] = []
    
    private lazy var titleNavi = CustomBackNaviView(title: "PickMov:)e", backButton: backBtn)
    private lazy var backBtn = NaviButton(image: UIImage(systemName: "chevron.left"))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraint()
//        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tabBarController?.tabBar.isHidden = false
    }
    
    private func setUI() {
        
        setLayout()
        navigationController?.navigationBar.isHidden = true
//        tabBarController?.tabBar.isHidden = true
        collectionV.backgroundColor = .white
        collectionV.dataSource = self
        collectionV.isScrollEnabled = false
        
        collectionV.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: MovieDetailCollectionViewCell.identifier)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    private func setLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setConstraint() {
        [titleNavi, collectionV].forEach {
            view.addSubview($0)
        }
        
        titleNavi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        collectionV.snp.makeConstraints {
            $0.top.equalTo(titleNavi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.identifier, for: indexPath) as! MovieDetailCollectionViewCell
        
        var image = UIImage()
        if detailData[indexPath.item].image == "" {
            image = UIImage(named: "noposter")!
        } else {
            let img = detailData[indexPath.item].image
            guard let imgURL = URL(string: img) else { return cell }
            guard let imgData = try? Data(contentsOf: imgURL) else { return cell }
            image = UIImage(data: imgData) ?? UIImage(named: "noposter")!
        }
        
        let title = detailData[indexPath.item].title
        let titleResult = title.stringChange()
        
        let subTitle = detailData[indexPath.item].subtitle
        let subTitleResult = subTitle.stringChange()
        
        let date = detailData[indexPath.item].pubDate
        
        let directorString = detailData[indexPath.item].director
        let directorResult = directorString.stringChange()
        
        let actorString = detailData[indexPath.item].actor
        
        let actorResult = actorString.stringChange()
        
        let userRating = detailData[indexPath.item].userRating
        
        cell.configure(image: image, title: titleResult, subTitle: subTitleResult, pubDate: date, dirString: directorResult, actString: actorResult, ratingString: userRating)
        
        cell.moreButton.addTarget(self, action: #selector(moreMovie(_:)), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(addList(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func back() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addList(_ sender: UIButton) {
        let vc = AddMovieViewController()
        vc.movieInfo = self.detailData[0]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moreMovie(_ sender: UIButton) {
        let link = LinkViewController()
        let url = detailData[0].link
        let title = detailData[0].title
        let titleResult = title.stringChange()
        link.upViewTitle.text = titleResult
        link.url = url
        
        present(link, animated: true)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    
}
