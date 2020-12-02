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
    private lazy var collectionV = UICollectionView(
        frame: .zero, collectionViewLayout: layout
    )
    
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
        tabBarController?.tabBar.isHidden = true
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

        let img = detailData[indexPath.item].image
        
        guard let imgURL = URL(string: img) else { return cell }
        guard let imgData = try? Data(contentsOf: imgURL) else { return cell }
        let image = UIImage(data: imgData)
        
        let title = detailData[indexPath.item].title
        let titleResult = title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "&amp", with: "")
        
        let subTitle = detailData[indexPath.item].subtitle
        let subTitleResult = subTitle.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "&amp", with: "")
        
        let date = detailData[indexPath.item].pubDate
        
        let directorString = detailData[indexPath.item].director
        let directorResult = directorString.replacingOccurrences(of: "|", with: " ")
        
        let actorString = detailData[indexPath.item].actor
        
        let actorResult = actorString.replacingOccurrences(of: "|", with: " ")
        
        let userRating = detailData[indexPath.item].userRating
        
        cell.configure(image: image!, title: titleResult, subTitle: subTitleResult, pubDate: date, dirString: directorResult, actString: actorResult, ratingString: userRating)
        
        cell.moreButton.addTarget(self, action: #selector(moreMovie(_:)), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(addList(_:)), for: .touchUpInside)
        cell.backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return cell
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addList(_ sender: UIButton) {
        let title = detailData[0].title
        let link = detailData[0].link
        let poster = detailData[0].image
        
        struct MovieList {
            var title: String
            var listname: String
            var link: String
            var poster: String
        }
        
        let movie = MovieList(
            title: title,
            listname: "",
            link: link,
            poster: poster
        )
        
        let persistenceManager = PersistenceManager.shared
        let context = persistenceManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieList", in: context)
        
        if let entity = entity {
            let movieList = NSManagedObject(entity: entity, insertInto: context)
            movieList.setValue(movie.title, forKey: "title")
            movieList.setValue(movie.listname, forKey: "listname")
            movieList.setValue(movie.poster, forKey: "poster")
            movieList.setValue(movie.link, forKey: "link")
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    @objc func moreMovie(_ sender: UIButton) {
        let link = LinkViewController()
        let url = detailData[0].link
        let title = detailData[0].title
        let titleResult = title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        link.upViewTitle.text = titleResult
        link.url = url
        
        present(link, animated: true)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    
}
