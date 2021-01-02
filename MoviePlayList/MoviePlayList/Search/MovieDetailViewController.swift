//
//  MovieDetailViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(frame: .zero,
                                                    collectionViewLayout: layout)
    
    var detailData: [MovieInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraint()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setUI() {
        view.addSubview(collectionV)
        setLayout()
        navigationController?.navigationBar.isHidden = true
//        tabBarController?.tabBar.isHidden = true
        collectionV.backgroundColor = .white
        collectionV.dataSource = self
        collectionV.isScrollEnabled = false
        
        collectionV.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: MovieDetailCollectionViewCell.identifier)
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
        collectionV.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(view.safeAreaInsets)
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
        cell.backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return cell
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addList(_ sender: UIButton) {

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
