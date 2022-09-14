//
//  ProductsCollectionViewCell.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import UIKit
import AlamofireImage

class ProductsCollectionViewCell: UICollectionViewCell {
    
    // MARK: View
    
    private let productImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private var addBadge: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("0", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private let titleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let campaignPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        
        configureCell()
        configureConstraint()
    }
    
    // MARK: Func
    
    func configureCell() {
        contentView.addSubview(productImage)
        contentView.addSubview(addBadge)
        contentView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleName)
        verticalStack.addArrangedSubview(price)
        verticalStack.addArrangedSubview(campaignPrice)
        
        productImage.layer.cornerRadius = 5
    }
    
    func configureProducts(products: Products) {
        
        self.productImage.af.setImage(withURL: URL(string: (products.featuredImage?.t)!)!)
        self.titleName.text = products.title
        self.price.text = Constants.Properties.Price + "\(products.price!)"
        
        if products.campaignPrice == nil {
            campaignPrice.removeFromSuperview()
        } else {
            self.campaignPrice.text = Constants.Properties.Campaing_Price + "\(products.campaignPrice ?? 0)"
        }
        
        if products.stock == 0 {
           print("product isn't in stock")
        } else {
            addBadge.isHidden = true
        }
    }
    
    func configureConstraint() {
        
        let padding: CGFloat = 4
        let diameter: CGFloat = 30
        
        NSLayoutConstraint.activate([
            
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            productImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.5 ),
            productImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
            addBadge.heightAnchor.constraint(equalToConstant: diameter),
            addBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: diameter),
            addBadge.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding * 10),
            addBadge.bottomAnchor.constraint(equalTo: contentView.topAnchor , constant: padding  * 10),
            
            verticalStack.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: contentView.frame.width - padding * 2),
        
            titleName.topAnchor.constraint(equalTo: verticalStack.topAnchor, constant: padding),
            titleName.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            titleName.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -padding),
            
            price.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: padding),
            price.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            price.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -padding),
            
            campaignPrice.topAnchor.constraint(equalTo: price.bottomAnchor, constant: padding),
            campaignPrice.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            campaignPrice.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -padding),
            campaignPrice.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: -padding)
        ])
    }
}
