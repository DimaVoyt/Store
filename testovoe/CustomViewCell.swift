//
//  CustomViewCell.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import Kingfisher



class CustomViewCell: UITableViewCell {
    
    let countTextField: UITextField = {
        let tf = UITextField()
        tf.tintColor = .black
        tf.font = .systemFont(ofSize: 15)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let imageV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.tintColor = .black
        tf.font = .systemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.tintColor = .black
        tf.font = .systemFont(ofSize: 17)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with product: Product) {
        countTextField.text = product.count
        priceTextField.text = product.price
        nameTextField.text = product.name
        imageV.kf.setImage(with: URL(string: product.imageURL))
    }
}

extension CustomViewCell {
    func setupConstraints() {
        contentView.addSubview(imageV)
        contentView.addSubview(countTextField)
        contentView.addSubview(priceTextField)
        contentView.addSubview(nameTextField)
        
        imageV.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        imageV.heightAnchor.constraint(equalToConstant: 75).isActive = true
        imageV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: imageV.rightAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        
        countTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        countTextField.leftAnchor.constraint(equalTo: imageV.rightAnchor, constant: 12).isActive = true
        
        priceTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
}
