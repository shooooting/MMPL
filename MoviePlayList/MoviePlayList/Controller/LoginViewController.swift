//
//  LoginViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/25.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email..."
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
        field.placeholder = "Password..."
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
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConfigure()
    }
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        [emailField, passwordField, loginButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConfigure() {
        emailField.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(-100)
            $0.leading.equalTo(view.snp.leading).offset(32)
            $0.trailing.equalTo(view.snp.trailing).inset(32)
            $0.height.equalTo(52)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailField)
        }
    }
    


}
