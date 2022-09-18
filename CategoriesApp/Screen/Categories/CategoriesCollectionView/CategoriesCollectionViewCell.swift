//
//  MainCollectionViewCell.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import UIKit
import Alamofire

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: View
    
    private let horizontalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    private let categoryIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
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
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(categoryIcon)
        horizontalStack.addArrangedSubview(categoryName)
        
        categoryIcon.layer.cornerRadius = 5
    }
    
    func configureName(category: Categories) {
        self.categoryIcon.af.setImage(withURL: URL(string: category.icon!)!)
        self.categoryName.text = category.name
    }
    
    func configureConstraint() {
        
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(3)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-3)
        }
        
        categoryIcon.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.top).offset(3)
            make.bottom.equalTo(horizontalStack.snp.bottom).offset(-3)
            make.width.equalTo(70)
        }
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.top).offset(3)
            make.left.equalTo(categoryIcon.snp.right).offset(20)
            make.bottom.equalTo(horizontalStack.snp.bottom).offset(-3)
        }
    }
}
