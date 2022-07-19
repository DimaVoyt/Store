//
//  ViewController.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage



class ProductsViewController: UIViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomViewCell
        cell.setup(with: products[indexPath.row])
        return cell
    }
    
    private let auth = Auth.auth()
    private var productsListenerRegistration: ListenerRegistration?
    private let firestore = Firestore.firestore()
    private var products = [Product]()
    
    deinit {
        productsListenerRegistration?.remove()
    }
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        view.backgroundColor = .white
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        addProductsListener()
        setupConstraints()
    }
    
}

private extension ProductsViewController {
    func setupNavigationTitle() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .plain, target: self, action: #selector(addProduct))
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func addProduct() {
        let vc = AddProductViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch {}
        navigation.switchToLogin()
    }
    
    func addProductsListener() {
        guard let currentUser = auth.currentUser else { return }
        productsListenerRegistration = firestore.collection("products")
            .whereField("userUid", isEqualTo: currentUser.uid)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self, let snapshot = snapshot else { return }
                
                let documents = snapshot.documents.map { $0.data() }
                let products = documents.map { values -> Product in
                    return Product(id: values["id"] as? String ?? "",
                                   count: values["count"] as? String ?? "",
                                   name: values["name"] as? String ?? "",
                                   price: values["price"] as? String ?? "",
                                   imageURL: values["imageURL"] as? String ?? "")
                }
                
                self.products = products
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        let productInfoViewController = ProductsInfoViewController(product: product)
        navigationController?.pushViewController(productInfoViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, swipeButtonView, completion in
            guard let self = self else { return }
            
            let product = self.products[indexPath.row]
            self.firestore.collection("products").document(product.id).delete() { err in
                if err != nil {
                    completion(false)
                    print(err!)
                    return
                }
            }
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
