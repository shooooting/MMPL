//
//  LoginViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/25.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol AuthenticationControllerProtocol {
    func checkTextStatus()
}

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    private let titleIMG: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "film.fill")
        img.tintColor = .black
        return img
    }()
    
    private lazy var emailView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private lazy var passwordView: UIView = {
        return InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
    }()
    
    private let passwordTextField = CustomTextField(placeholder: "Password")
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let AccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "앱 사용자 등록",
                                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.systemGray])
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAction()
        keyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - UI
    private func setUI() {
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = .white
        
        view.addSubview(titleIMG)
        titleIMG.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        
        [emailView, passwordView, loginButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
        let stack = UIStackView(arrangedSubviews: [emailView, passwordView, loginButton])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(titleIMG.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(AccountButton)
        AccountButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
        }
        
        [emailTextField, passwordTextField].forEach {
            $0.delegate = self
        }
    }
    
    // MARK: - Button Action
    private func setAction() {
        AccountButton.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - Selector
extension LoginViewController {
    @objc
    private func didTapLogin() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthServiece.shared.loginUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("DEBUG: 로그인 에러 \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkTextStatus()
    }
    
    @objc
    private func didTapAccountButton() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 80
        }
    }
    
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y += 80
        }
    }
}

// MARK: - AuthenticationControllerProtocol
extension LoginViewController: AuthenticationControllerProtocol {
    func checkTextStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .black
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapLogin()
        }
        return true
    }
}

// MARK: - Keyboard NotificationCenter
extension LoginViewController {
    func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
}
