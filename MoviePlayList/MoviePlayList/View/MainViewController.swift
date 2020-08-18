//
//  ViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/10.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class MainViewController: UIViewController {
  
  var isPlayList = false
  
  private let upV: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  
  private let upViewTitle = UILabel()
  
  private let collectionV: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  var isOneStepPaging = true
  var currentIndex: CGFloat = 0
  
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
    static let inset: UIEdgeInsets = .init(top: 30, left: 30, bottom: 30, right: 30)
  }
  
  private func setUI() {
    [upV, upViewTitle, collectionV].forEach {
      view.addSubview($0)
    }
    
    upViewTitle.text = "PlayL:)st"
    upViewTitle.font = UIFont.boldSystemFont(ofSize: 35)
    
    collectionV.backgroundColor = .systemBackground
    collectionV.dataSource = self
    collectionV.delegate = self
    collectionV.register(MakeListCollectionViewCell.self, forCellWithReuseIdentifier: MakeListCollectionViewCell.identifier)
    collectionV.decelerationRate = UIScrollView.DecelerationRate.fast
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
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
    
    collectionV.snp.makeConstraints {
      $0.top.equalTo(upV.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom)
    }
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
    if isPlayList == false {
      let makeListView = MakeListViewController()
      navigationController?.pushViewController(makeListView, animated: true)
    }
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




