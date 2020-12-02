//
//  MakeListViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class MakeListViewController: UIViewController {
    
    private let upV: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let upViewTitle = UILabel()
    private let searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.borderStyle = .none
        searchBar.textColor = UIColor.black
        searchBar.placeholder = "검색어를 입력해주세요."
        return searchBar
    }()
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(
        frame: .zero, collectionViewLayout: layout
    )
    
    private let border = CALayer()
    
    private var data: SearchResult? {
        didSet {
            DispatchQueue.main.async {
                //        self.collectionV.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
        
        searchBar.accessibilityIdentifier = "영화제목"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        border.frame = CGRect(x: 0, y: searchBar.frame.size.height-1, width: searchBar.frame.width, height: 2)
        border.backgroundColor = UIColor.black.cgColor
        
    }
    
    private func setUI() {
        [upV, upViewTitle, searchBar, collectionV].forEach {
            view.addSubview($0)
        }
        setCollectionViewLayout()
        
        
        searchBar.layer.addSublayer(border)
        searchBar.delegate = self
        
        upViewTitle.text = "MakeL:)st"
        upViewTitle.font = UIFont.boldSystemFont(ofSize: 35)
        
        collectionV.backgroundColor = .systemBackground
        
        self.tabBarController?.delegate = self
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(MakeListMovieCollectionViewCell.self, forCellWithReuseIdentifier: MakeListMovieCollectionViewCell.identifier)
    }
    
    private func setCollectionViewLayout() {
        let width = view.frame.width / 3 - 16
        layout.itemSize = CGSize(width: width, height: width * 1.55)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func setConstraint() {
        upV.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        upViewTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(upV.snp.bottom).inset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(upV.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().offset(-32)
            $0.height.equalTo(44)
        }
        collectionV.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func requestAPI(queryValue: String) {
        let clientID: String = "8RNYIPCx6b6qFpZB6a2V"
        let clientKey: String = "5Vs0V727Ij"
        
        let query: String = "https://openapi.naver.com/v1/search/movie.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-naver-Client-Id")
        requestURL.addValue(clientKey, forHTTPHeaderField: "X-naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard error == nil else { return }
            guard let data = data else { return }
            
            //      do {
            //        let searchInfo: SearchResult = try JSONDecoder().decode(SearchResult.self, from: data)
            //        dataManager.shared.searchResult = searchInfo
            //        self.data.append(searchInfo)
            //
            //      } catch {
            //        print(error)
            //      }
            
            if let jsonData = try? JSONDecoder().decode(SearchResult.self, from: data) {
                //        let selectData: SearchResult
                //        for jData in jsonData.items {
                //            print(data.title, data.userRating)
                //            let score: Double
                //            score = Double(data.userRating) ?? 0
                //        }
                self.data = jsonData
                DispatchQueue.main.async { // ui를 변경하는 queue에 이 내용을 짚어 넣는다.
                    self.collectionV.reloadData()
                }
            }
        }
        task.resume()
    }
}

extension MakeListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let queryValue: String = searchBar.text ?? ""
        requestAPI(queryValue: queryValue)
        searchBar.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchBar.text = ""
    }
}

extension MakeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data?.items else {
            return 0
        }
        for score in data {
            if Double(score.userRating) ?? 0 > 5 {
                print(score.title)
            }
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeListMovieCollectionViewCell.identifier, for: indexPath) as! MakeListMovieCollectionViewCell

        guard let imageData = data?.items[indexPath.item].image else { return UICollectionViewCell() }
        guard let imgURL = URL(string: imageData ) else { return cell }
        guard let imgData = (try? Data(contentsOf: imgURL)) ?? nil else { return cell }
        guard let img = UIImage(data: imgData) else { return cell }
        
        cell.configure(item: img)
        cell.img.contentMode = .scaleAspectFill
        
        return cell
    }
}

extension MakeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = MovieDetailViewController()
        if vc.detailData.isEmpty == true {
            vc.detailData.append(data!.items[indexPath.item])
        } else {
            vc.detailData.removeAll()
            vc.detailData.append(data!.items[indexPath.item])
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MakeListViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        data?.items.removeAll()
        collectionV.reloadData()
        
    }
}
