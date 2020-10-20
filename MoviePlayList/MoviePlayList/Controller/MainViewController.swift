//
//  ViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let titleView = MainTitleView()
    let button = AddReviewButton(title: "새로운 영화 추가", style: .white)
  
    var isPlayList = false

    private let collectionV: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    var isOneStepPaging = true
    var currentIndex: CGFloat = 0
  
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setUI()
        setConstraint()
        fetchContact()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
//    }
  
    private func fetchContact() {
        let persistenceManage = PersistenceManager.shared
        let context = persistenceManage.persistentContainer.viewContext

        do {
          let contact = try context.fetch(MovieList.fetchRequest()) as! [MovieList]
          contact.forEach {
            print($0.self)
          }
        } catch {
          print(error.localizedDescription)
        }
    }
  
  private struct Standard {
    static let space: CGFloat = 15
    static let inset: UIEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
  }
  
    // MARK: - UI
    private func setUI() {
        [collectionV, titleView, button].forEach {
          view.addSubview($0)
        }

        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
            
        collectionV.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(button.snp.top).offset(-16)
        }

        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().offset(16).inset(16)
            $0.height.equalTo(55)
        }
    }
  
    private func setConstraint() {
        collectionV.backgroundColor = .systemBackground
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.register(MakeListCollectionViewCell.self, forCellWithReuseIdentifier: MakeListCollectionViewCell.identifier)
        collectionV.decelerationRate = UIScrollView.DecelerationRate.fast
        button.addTarget(self, action: #selector(tappedAddReviewButton), for: .touchUpInside)

      }
    
    @objc
    func tappedAddReviewButton(_ sender: UIButton) {
        let search = MakeListViewController()
//        navigationController?.pushViewController(search, animated: true)
        present(search, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeListCollectionViewCell.identifier, for: indexPath) as! MakeListCollectionViewCell
    return cell
  }
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let cellWidthIncludingSpacing = view.frame.width - Standard.inset.left - Standard.inset.right + Standard.space
    
    var offset = targetContentOffset.pointee // 이동했을때의 값을 좌표값으로 바꿔줌
    let index = offset.x / cellWidthIncludingSpacing
    var roundedIndex = round(index)
    
    if scrollView.contentOffset.x > targetContentOffset.pointee.x {
      roundedIndex = floor(index)
    } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
      roundedIndex = ceil(index)
    } else {
      roundedIndex = round(index)
    }
    
    if isOneStepPaging {
      if currentIndex > roundedIndex {
        currentIndex -= 1
        roundedIndex = currentIndex
      } else if currentIndex < roundedIndex {
        currentIndex += 1
        roundedIndex = currentIndex
      }
    }
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing, y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offset
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    Standard.inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Standard.space
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width - Standard.inset.left - Standard.inset.right
    let height = collectionView.frame.height - Standard.inset.top - Standard.inset.bottom
    return CGSize(width: width, height: height)
  }
}




