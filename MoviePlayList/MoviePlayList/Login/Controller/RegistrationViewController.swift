//
//  RegistrationViewController.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/17.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusbutton"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    }()
    
    private lazy var nicknameView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "person"), textField: nicknameTextField)
    }()
    
    private lazy var passwordView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let nicknameTextField = CustomTextField(placeholder: "Nick Name")
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "사용자 등록이 되어 있으세요?",
                                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.black])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
        
    }
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.height.equalTo(150)
        }
        
        [emailView, passwordView, nicknameView, signUpButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
        
        let stack = UIStackView(arrangedSubviews: [emailView,
                                                   passwordView,
                                                   nicknameView,
                                                   signUpButton])
        
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
        }
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
// MARK: - Selector
extension RegistrationViewController {
    @objc func handleRegistration() {
        
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.nickname = sender.text
        }
        
        checkTextStatus()
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController:  AuthenticationControllerProtocol {
    func checkTextStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .black
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .white
        }
    }
}
