//
//  RegistrationViewController.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



class RegistrationViewController: UIViewController {
    
    private let firestore = Firestore.firestore()
    
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 44)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 25)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.font = .systemFont(ofSize: 25)
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.borderWidth = 1
        button.tintColor = UIColor.systemYellow
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Имя"
        tf.font = .systemFont(ofSize: 25)
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        return tf
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Повторите пароль"
        tf.font = .systemFont(ofSize: 25)
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let secondPasswordView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupButtons()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        view.addSubview(registrationLabel)
        view.addSubview(registerButton)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        emailView.addSubview(emailTextField)
        passwordView.addSubview(passwordTextField)
        view.addSubview(nameView)
        nameView.addSubview(nameTextField)
        view.addSubview(secondPasswordView)
        secondPasswordView.addSubview(secondPasswordTextField)
        
        emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        emailView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 1).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 1).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: emailView.rightAnchor, constant: -1).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -1).isActive = true
        
        passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 15).isActive = true
        passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordView.widthAnchor.constraint(equalTo: emailView.widthAnchor).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 1).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 1).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -1).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -1).isActive = true
        
        secondPasswordView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 15).isActive = true
        secondPasswordView.widthAnchor.constraint(equalTo: passwordView.widthAnchor).isActive = true
        secondPasswordView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        secondPasswordTextField.topAnchor.constraint(equalTo: secondPasswordView.topAnchor, constant: 1).isActive = true
        secondPasswordTextField.leftAnchor.constraint(equalTo: secondPasswordView.leftAnchor, constant: 1).isActive = true
        secondPasswordTextField.rightAnchor.constraint(equalTo: secondPasswordView.rightAnchor, constant: -1).isActive = true
        secondPasswordTextField.bottomAnchor.constraint(equalTo: secondPasswordView.bottomAnchor, constant: -1).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: secondPasswordView.bottomAnchor, constant: 15).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.widthAnchor.constraint(equalTo: secondPasswordView.widthAnchor).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.layer.cornerRadius = 5
        
        registrationLabel.bottomAnchor.constraint(equalTo: emailView.topAnchor, constant: -60).isActive = true
        registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameView.bottomAnchor.constraint(equalTo: emailView.topAnchor, constant: -15).isActive = true
        nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameView.widthAnchor.constraint(equalTo: emailView.widthAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 1).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 1).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -1).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -1).isActive = true        
    }
}

private extension RegistrationViewController {
    
    func setupButtons() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func registerButtonTapped() {
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        if password == secondPasswordTextField.text {
            register(name: name, email: email, password: password)
        } else {
            let controller = UIAlertController(title: "Oops", message: "Пароли не совпадают", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
            return
        }
    }
    
    func register(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let authResult = authResult {
                let user = authResult.user
                let data: [String: Any] = [
                    "name": name,
                    "email": email
                ]
                self.firestore.collection("users").document(user.uid).setData(data) { error in
                    if error != nil {
                        print("\(String(describing: error))")
                    }
                }
            }
            if error != nil {
                print("\(String(describing: error))")
                return
            }
            navigation.switchToMain()
        }
    }
}
