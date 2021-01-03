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
    
    // MARK: - Propertise
    private var data: SearchResult?
    
    private lazy var upV = CustomMainNaviView(title: "MakeL:)st", button: personButton)
    private lazy var personButton = NaviButton(image: UIImage(systemName: "person.circle"))
    private lazy var searchBar = MovieSearchTextField()
    private lazy var noSearchView = NoSearchView(title: "검색된 영상가 없습니다.")
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(frame: .zero,
                                                    collectionViewLayout: layout)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setCollectionView()
        setAction()
        setUI()
        delegate()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    // MARK: - Helper
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
    
    private func searchMovie(keyword: String) {
        APIManager.shared.requestSearchAPI(queryValue: keyword) { data in
            self.data = data
            DispatchQueue.main.async {
                self.collectionV.reloadData()
                if self.data?.total == 0 {
                    self.animateWarning()
                }
            }
        }
    }
    
    // MARK: - Action
    private func setAction() {
        personButton.addTarget(self, action: #selector(didTapPersonButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapPersonButton() {
        let vc = ProfileViewController()
        vc.title = "Profile"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension MakeListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let queryValue: String = searchBar.text ?? ""
        searchMovie(keyword: queryValue)
        searchBar.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchBar.text = ""
    }
}

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegate
extension MakeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieInfo = data?.items[indexPath.item] else { return }
        let vc = MovieDetailViewController()
        if vc.detailData.isEmpty == true {
            vc.detailData.append(movieInfo)
        } else {
            vc.detailData.removeAll()
            vc.detailData.append(movieInfo)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
extension MakeListViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        data?.items.removeAll()
        collectionV.reloadData()
    }
}

// MARK: - CollectionView
extension MakeListViewController {
    
    private func setCollectionView() {
        collectionV.backgroundColor = .white
        setCollectionViewLayout()
        
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(MakeListMovieCollectionViewCell.self, forCellWithReuseIdentifier: MakeListMovieCollectionViewCell.identifier)
    }
    
    private func setCollectionViewLayout() {
        let width = view.frame.size.width
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width-4)/3, height: (width-4)/2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
    }
}

// MARK: - setUI
extension MakeListViewController {
    
    private func setUI() {
        [upV, searchBar, noSearchView, collectionV].forEach {
            view.addSubview($0)
        }
        
        upV.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(upV.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().offset(-32)
            $0.height.equalTo(44)
        }
        
        noSearchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-130)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
        
        collectionV.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func delegate() {
        searchBar.delegate = self
        self.tabBarController?.delegate = self
    }
}


