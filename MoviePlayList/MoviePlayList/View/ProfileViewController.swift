//
//  ProfileViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/26.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let titleView = MainTitleView()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.sizeToFit()
        return button
    }()
    
    private let menuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.sizeToFit()
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        [tableView, titleView].forEach {
            view.addSubview($0)
        }
        titleView.profileConfigure(with: "Profile", font: UIFont.boldSystemFont(ofSize: 20))
        
        [backButton, menuButton].forEach {
            titleView.addSubview($0)
        }
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        
        tableView.tableHeaderView = tableHeaderView()
    }
    
    private func setLayout() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaInsets)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        menuButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func tableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4).integral)
        let size = header.frame.height / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.frame.width - size)/2,
                                                        y: (header.frame.height - size)/2,
                                                        width: size,
                                                        height: size))
        
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfilePhotoButton),
                                     for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapMenuButton() {
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
                AuthManager.shared.logOut { success in
                        if success {
                            let loginVC = UINavigationController(rootViewController: LoginViewController())
                            loginVC.modalPresentationStyle = .fullScreen
                            self.present(loginVC, animated: true) {
                                self.navigationController?.popViewController(animated: false)
                                self.tabBarController?.selectedIndex = 0
                            }
                        } else {
                            fatalError("Could not log out user")
                        }
                }
        }))
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX,
                                                                       y: self.view.frame.midY / 4,
                                                                       width: 0,
                                                                       height: 0)
        
        present(actionSheet, animated: true)
    }
    
    @objc
    private func didTapProfilePhotoButton() {
        
    }
    
    
    
}
