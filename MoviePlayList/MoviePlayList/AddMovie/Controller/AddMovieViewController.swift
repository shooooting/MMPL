//
//  AddMovieViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/03.
//  Copyright © 2021 shooooting. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    // MARK: - Propertise
    var movieInfo: MovieInfo? {
        didSet {
            if movieInfo?.image == "" {
                posterButton.setBackgroundImage(UIImage(named: "noposter")!, for: .normal)
            } else {
                guard let img = movieInfo?.image else { return }
                guard let imgURL = URL(string: img) else { return }
                guard let imgData = try? Data(contentsOf: imgURL) else { return }
                posterButton.setBackgroundImage(UIImage(data: imgData), for: .normal)
            }
        }
    }
    private var review = [Review]()
    
    private lazy var titleNavi = AddMovieNaviView(title: "MyMov:)e",
                                                  movieName: movieInfo?.title ?? "",
                                                  posterButton: posterButton,
                                                  backButton: backBtn)
    private var posterButton = UIButton()
    private lazy var backBtn = NaviButton(image: UIImage(systemName: "chevron.left"))
    private lazy var customInputView = AccessoryView()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCollectionView()
        setAction()
        downReviews()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Down Review Data
    private func downReviews() {
        guard let movie = movieInfo else { return }
        Service.downReview(movie.title) { reviews in
            self.review = reviews
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.review.count - 1], at: .bottom, animated: true)
        }
    }
    
    // MARK: - setAction
    private func setAction() {
        backBtn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        posterButton.addTarget(self, action: #selector(didTapPosterButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    private func didTapPosterButton() {
        guard let movieInfo = self.movieInfo else { return }
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

// MARK: - CollectionViewDataSource
extension AddMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return review.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMovieCell.identifier, for: indexPath) as! AddMovieCell
        cell.review = review[indexPath.row]
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension AddMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedSizeCell = AddMovieCell()
        estimatedSizeCell.review = review[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

// MARK: - CollectionView
extension AddMovieViewController {
    private func setCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AddMovieCell.self, forCellWithReuseIdentifier: AddMovieCell.identifier)
    }
}

// MARK: - setUI
extension AddMovieViewController {
    private func setUI() {
        view.backgroundColor = .white
        customInputView.delegate = self
        [titleNavi, collectionView].forEach {
            view.addSubview($0)
        }
        
        titleNavi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleNavi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension AddMovieViewController: AccessoryViewDelegate {
    func inputView(_ inputView: AccessoryView, wantsToSend message: String) {
        guard let movie = movieInfo else { return }
        
        Service.uploadReview(message, movieTitle: movie.title) { error in
            if let error = error {
                print("DEBUG: AddMovieViewController uploadReview \(error.localizedDescription)")
                return
            }
        }
        
        inputView.clearMessageText()
    }
}
