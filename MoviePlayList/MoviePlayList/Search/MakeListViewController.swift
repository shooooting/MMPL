//
//  MakeListViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import Kingfisher

class MakeListViewController: UIViewController {
    
    private var data: SearchResult? {
        didSet {
            if data?.total == 0 || data?.total == nil {
                animateWarning()
            }
        }
    }
    
    private let upV: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let personButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.layer.masksToBounds = true
        button.tintColor = .black
        button.sizeToFit()
        return button
    }()
    
    private let upViewTitle = UILabel()
    private let searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.borderStyle = .none
        searchBar.textColor = UIColor.black
        searchBar.placeholder = "검색어를 입력해주세요."
        return searchBar
    }()
    
    private lazy var noSearchView = NoSearchView(title: "검색된 영상가 없습니다.")
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(frame: .zero,
                                                    collectionViewLayout: layout)
    
    private let border = CALayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        border.frame = CGRect(x: 0, y: searchBar.frame.size.height-1, width: searchBar.frame.width, height: 2)
        border.backgroundColor = UIColor.black.cgColor
    }
    
    // MARK: - Helper
    
    private func setUI() {
        [upV, personButton, upViewTitle, searchBar].forEach {
            view.addSubview($0)
        }
        navigationController?.navigationBar.isHidden = true
        
        searchBar.layer.addSublayer(border)
        searchBar.delegate = self
        
        upViewTitle.text = "MakeL:)st"
        upViewTitle.font = UIFont.boldSystemFont(ofSize: 35)
        
        collectionV.backgroundColor = .white
        collectionV.tag = 100
        setCollectionViewLayout()
        
        self.tabBarController?.delegate = self
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(MakeListMovieCollectionViewCell.self, forCellWithReuseIdentifier: MakeListMovieCollectionViewCell.identifier)
        
        view.addSubview(noSearchView)
        noSearchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-130)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
    }
    
    private func animateWarning() {
        noSearchView.isHidden = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            animations: {
                self.noSearchView.snp.updateConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide)
                }
                self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(
                withDuration: 0.4,
                delay: 1.5,
                animations: {
                    self.noSearchView.snp.updateConstraints {
                        $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-130)
                    }
                    self.view.layoutIfNeeded()
            }, completion: { _ in return self.noSearchView.isHidden = true })
        })
    }
    
    private func setCollectionViewLayout() {
        let width = view.frame.size.width
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width-4)/3, height: (width-4)/2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
    }
    
    private func setConstraint() {
        upV.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
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
        
        personButton.snp.makeConstraints {
            $0.centerY.equalTo(upViewTitle.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(30)
        }
        
        personButton.addTarget(self, action: #selector(didTapPersonButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapPersonButton() {
        let vc = ProfileViewController()
        vc.title = "Profile"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func searchMovie(keyword: String) {
        APIManager.shared.requestSearchAPI(queryValue: keyword) { data in
            self.data = data
            DispatchQueue.main.async {
                self.collectionV.reloadData()
            }
        }
    }
}

extension MakeListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let queryValue: String = searchBar.text ?? ""
        searchMovie(keyword: queryValue)
        searchBar.resignFirstResponder()
        view.addSubview(collectionV)
        collectionV.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchBar.text = ""
    }
}

extension MakeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.items.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeListMovieCollectionViewCell.identifier, for: indexPath) as! MakeListMovieCollectionViewCell
        
        cell.movieInfo = self.data?.items[indexPath.row]
        return cell
    }
}

extension MakeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfo = data?.items[indexPath.item]
        let vc = MovieDetailViewController()
        if vc.detailData.isEmpty == true {
            vc.detailData.append(movieInfo!)
        } else {
            vc.detailData.removeAll()
            vc.detailData.append(movieInfo!)
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
