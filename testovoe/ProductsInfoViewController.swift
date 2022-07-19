//
//  ProductsInfoViewController.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Kingfisher



class ProductsInfoViewController: UIViewController {
    
    private let product: Product
    
    private let firestore = Firestore.firestore()
    
    enum AppError: Error {
        case unknown
    }
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.on.rectangle")
        iv.tintColor = .gray
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Название"
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 25)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Цена"
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 25)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let countTextField: UITextField = {
        let tf = UITextField()
        tf.text = "Количество"
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 25)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = UIColor.black
        
        return tf
    }()
    
    let countView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let priceView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        priceTextField.text = product.price
        countTextField.text = product.count
        nameTextField.text = product.name
        imageView.kf.setImage(with: URL(string: product.imageURL))
        setupConstraints()
        titleName()
        setupButtons()
        setupNavigationTitle()
    }
    
    func titleName() {
        firestore.collection("products").document(product.id)
            .getDocument { [weak self] snapshot, error in
                guard let self = self, let userData = snapshot?.data() else { return }
                let title = userData["name"] as? String
                self.title = title
            }
    }
}

private extension ProductsInfoViewController {
    func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(countView)
        view.addSubview(priceView)
        view.addSubview(nameView)
        countView.addSubview(countTextField)
        priceView.addSubview(priceTextField)
        nameView.addSubview(nameTextField)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 1).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 1).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -1).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -1).isActive = true
        
        countView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 15).isActive = true
        countView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countView.widthAnchor.constraint(equalTo: nameView.widthAnchor).isActive = true
        
        countTextField.topAnchor.constraint(equalTo: countView.topAnchor, constant: 1).isActive = true
        countTextField.leftAnchor.constraint(equalTo: countView.leftAnchor, constant: 1).isActive = true
        countTextField.rightAnchor.constraint(equalTo: countView.rightAnchor, constant: -1).isActive = true
        countTextField.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -1).isActive = true
        
        priceView.topAnchor.constraint(equalTo: countView.bottomAnchor, constant: 15).isActive = true
        priceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        priceView.widthAnchor.constraint(equalTo: nameView.widthAnchor).isActive = true
        
        priceTextField.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 1).isActive = true
        priceTextField.leftAnchor.constraint(equalTo: priceView.leftAnchor, constant: 1).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: priceView.rightAnchor, constant: -1).isActive = true
        priceTextField.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -1).isActive = true
    }
}

extension ProductsInfoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func setupButtons() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tap)
    }
    
    func setupNavigationTitle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(saveNote))
    }
    
    @objc func saveNote() {
        guard let name = nameTextField.text,
              let price = priceTextField.text,
              let count = countTextField.text,
              let _ = Auth.auth().currentUser else { return }
        let noteDoc = self.firestore.collection("products").document(product.id)
        upload(imageId: noteDoc.documentID, image: imageView.image!) { result in
            switch result {
            case .success(let url):
                let data: [String: Any] = [
                    "name": name,
                    "price": price,
                    "count": count,
                    "imageURL": url.absoluteString,
                    "timestamp": FieldValue.serverTimestamp()
                ]
                noteDoc.updateData(data)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error): print(error)
            }
        }
    }
    
    @objc func imageViewTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = image
    }
    
    func upload(imageId: String, image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser, let imageData = imageView.image?.jpegData(compressionQuality: 0.4) else {
            completion(.failure(AppError.unknown))
            return
        }
        
        let ref = Storage.storage().reference().child(currentUser.uid).child(imageId + ".jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata  else {
                completion(.failure(error ?? AppError.unknown))
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error ?? AppError.unknown))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
