//
//  LoginViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/25.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MMPL"
        label.font = UIFont.boldSystemFont(ofSize: 75)
        return label
    }()
    
    private let UsernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemGray3
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setAction()
    }
    // MARK: - UI
    private func setUI() {
        view.backgroundColor = .systemBackground
        [titleLabel, UsernameEmailField, passwordField, loginButton, createAccountButton].forEach {
            view.addSubview($0)
        }
        UsernameEmailField.delegate = self
        passwordField.delegate = self
    }
    // MARK: - Layout
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(UsernameEmailField.snp.top)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
        }
        
        UsernameEmailField.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(-100)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
            $0.height.equalTo(52)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(UsernameEmailField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(UsernameEmailField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(UsernameEmailField)
        }
        
        createAccountButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    // MARK: - Button Action
    private func setAction() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    @objc
    private func didTapLogin() {
        [UsernameEmailField, passwordField].forEach {
            $0.resignFirstResponder()
        }
        
        guard let usernameEmail = UsernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
    }
    
    @objc
    private func didTapCreateAccount() {
        let vc = NewUserViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UsernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLogin()
        }
        return true
    }
}
