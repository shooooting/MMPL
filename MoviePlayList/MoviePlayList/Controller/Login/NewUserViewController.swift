//
//  NewUserViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/26.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    
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
    
    private let EmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
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
        field.placeholder = "password..."
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
    
    private let registerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setAction()
    }
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        [usernameField, EmailField, passwordField, registerButton].forEach {
            view.addSubview($0)
        }
        [usernameField, EmailField, passwordField].forEach {
            $0.delegate = self
        }
    }
    
    private func setLayout() {
        
        usernameField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
            $0.height.equalTo(52)
        }
        
        EmailField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(usernameField)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(EmailField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(usernameField)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(usernameField)
        }
    }
    
    private func setAction() {
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapRegisterButton() {
        [usernameField, EmailField, passwordField].forEach {
            $0.resignFirstResponder()
        }
        
        guard let email = EmailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            if registered {
                // success
                print("성공")
            } else {
                // failed
                print("실패")
            }
        }
    }
}

extension NewUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            EmailField.becomeFirstResponder()
        } else if textField == EmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTapRegisterButton()
        }
        return true
    }
}
