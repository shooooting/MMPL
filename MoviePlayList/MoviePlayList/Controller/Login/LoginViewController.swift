//
//  LoginViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/25.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MMPL"
        label.font = UIFont.boldSystemFont(ofSize: 75)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 등록"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
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
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAction()
    }
    
    // MARK: - UI
    private func setUI() {
        view.backgroundColor = .systemBackground
        [titleLabel, subTitleLabel, emailField, usernameField, passwordField, loginButton].forEach {
            view.addSubview($0)
        }
        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
    }
    // MARK: - Layout
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(view.snp.leading).offset(32)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(-100)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
            $0.height.equalTo(52)
        }
        
        usernameField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailField)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailField)
        }
    }
    // MARK: - Button Action
    private func setAction() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc
    private func didTapLogin() {
        
        [usernameField, emailField, passwordField].forEach {
            $0.resignFirstResponder()
        }
        
        guard let email = emailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        AuthManager.shared.logInUser(email: email, password: password) { success in
            if success {
                print("로그인")
            } else {
                print("로그인 실패")
            }
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            if registered {
                // success
                print("성공")
                self.dismiss(animated: true)
            } else {
                // failed
                print("실패")
            }
        }

    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            usernameField.becomeFirstResponder()
        } else if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLogin()
        }
        return true
    }
}
