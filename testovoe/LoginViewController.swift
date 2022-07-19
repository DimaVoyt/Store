//
//  LoginViewController.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



class LoginViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 44)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in"
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.borderWidth = 1
        button.tintColor = UIColor.systemYellow
        button.setTitle("Войти", for: .normal)
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
    
    let recoveryPassButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.tintColor = UIColor.systemYellow
        butt.backgroundColor = .white
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        butt.setTitle("Восстановление пароля", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.systemYellow
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupButtons()
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupConstraints() {
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        emailView.addSubview(emailTextField)
        passwordView.addSubview(passwordTextField)
        view.addSubview(recoveryPassButton)
        view.addSubview(registerButton)
        
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
        
        loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 15).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalTo: passwordView.widthAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.layer.cornerRadius = 5
        
        loginLabel.bottomAnchor.constraint(equalTo: emailView.topAnchor, constant: -60).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        recoveryPassButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        recoveryPassButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        recoveryPassButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        recoveryPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: recoveryPassButton.bottomAnchor, constant: 30).isActive = true
        registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

private extension LoginViewController {
    
    func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        recoveryPassButton.addTarget(self, action: #selector(recoveryPassButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        login(email: email, password: password)
    }
    
    @objc func recoveryPassButtonTapped() {
        let vc = RecoveryPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            if error != nil {
                let controller = UIAlertController(title: "Oops", message: "Ввевены не верные данные", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
                print(error!)
                return
            } else {
                navigation.switchToMain()
            }
        }
    }
}
