//
//  ProfileViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/26.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var AuthUser = [User]() {
        didSet {
            guard let url = URL(string: AuthUser[0].profileImageUrl) else { return }
            selectProfileImageButton.kf.setImage(with: url, for: .normal)
            selectProfileImageButton.layer.cornerRadius = 200 / 2
        }
    }
    private lazy var titleView: MainTitleView = {
        let view = MainTitleView()
        view.profileConfigure(with: "Profile", font: UIFont.boldSystemFont(ofSize: 20))
        return view
    }()
    
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
    
//    private let collectionView: UICollectionView = {
//        let collection = UICollectionView()
//        return collection
//    }()
    
    private let selectProfileImageButton: UIButton = {
        let img = UIButton()
        img.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        img.tintColor = .black
        img.layer.cornerRadius = 200 / 2
        img.imageView?.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        ProfileImageAction()
        authUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        [selectProfileImageButton, titleView].forEach {
            view.addSubview($0)
        }
        
        [backButton, menuButton].forEach {
            titleView.addSubview($0)
        }
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
    }
    
    private func authUser() {
        Service.LoginUser { user in
            self.AuthUser = user
        }
    }
    
    private func setLayout() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        selectProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(200)
        }
        
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(titleView.snp.bottom)
//            $0.leading.trailing.bottom.equalTo(view.safeAreaInsets)
//        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        menuButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
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
}

// MARK: - ProfileImage Action

extension ProfileViewController {

    private func ProfileImageAction() {
        selectProfileImageButton.addTarget(self, action: #selector(handleProfileImageButton), for: .touchUpInside)
    }

    @objc
    private func handleProfileImageButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        selectProfileImageButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        selectProfileImageButton.layer.cornerRadius = 200 / 2
        
        Service.updateUserData(name: image) { error in
            if let error = error {
                print("DEBUG: Failed to upload \(error.localizedDescription)")
                return
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
