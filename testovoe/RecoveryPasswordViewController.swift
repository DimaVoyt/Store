//
//  RecoveryPasswordViewController.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import FirebaseAuth

class RecoveryPasswordViewController: UIViewController {
    
    let recoveryPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Восстановление пароля"
        return label
    }()
    
    let recoveryPassTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 25)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        return tf
    }()
    
    let recoveryPassView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.borderWidth = 1
        button.tintColor = UIColor.systemYellow
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
        view.addSubview(recoveryPassView)
        recoveryPassView.addSubview(recoveryPassTextField)
        view.addSubview(recoveryPassLabel)
        view.addSubview(sendButton)
        
        recoveryPassView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recoveryPassView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        recoveryPassView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        recoveryPassTextField.topAnchor.constraint(equalTo: recoveryPassView.topAnchor, constant: 1).isActive = true
        recoveryPassTextField.leftAnchor.constraint(equalTo: recoveryPassView.leftAnchor, constant: 1).isActive = true
        recoveryPassTextField.rightAnchor.constraint(equalTo: recoveryPassView.rightAnchor, constant: -1).isActive = true
        recoveryPassTextField.bottomAnchor.constraint(equalTo: recoveryPassView.bottomAnchor, constant: -1).isActive = true
        
        recoveryPassLabel.bottomAnchor.constraint(equalTo: recoveryPassView.topAnchor, constant: -60).isActive = true
        recoveryPassLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        sendButton.topAnchor.constraint(equalTo: recoveryPassView.bottomAnchor, constant: 15).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.widthAnchor.constraint(equalTo: recoveryPassView.widthAnchor).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.layer.cornerRadius = 5
    }
}

private extension RecoveryPasswordViewController {
    func setupButtons() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendButtonTapped() {
        guard let email = recoveryPassTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                let controller = UIAlertController(title: "Oops", message: "Ввевена не действительная почта", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
                print("\(String(describing: error))")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
