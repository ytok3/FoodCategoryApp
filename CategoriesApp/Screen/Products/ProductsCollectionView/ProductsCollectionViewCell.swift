//
//  ProductsCollectionViewCell.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import UIKit
import AlamofireImage
import SnapKit

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
        button.backgroundColor = .systemGray
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
        
        productImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(3)
            make.left.equalTo(contentView).offset(3)
            make.right.equalTo(contentView).offset(-3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(140)
        }
        
        addBadge.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.left).offset(-40)
            make.bottom.equalTo(contentView.snp.top).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(3)
            make.left.equalTo(contentView).offset(3)
            make.right.equalTo(contentView).offset(-3)
            make.bottom.equalTo(contentView).offset(-3)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        titleName.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.top).offset(3)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(titleName.snp.bottom).offset(3)
        }
        
        campaignPrice.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(3)
            make.bottom.equalTo(verticalStack.snp.bottom).offset(-3)
        }
    }
}
