//
//  ProductDetailViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 11.09.2022.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: View
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let noResult: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var scroolView: UIScrollView = {
        let scroolView = UIScrollView()
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        scroolView.isScrollEnabled = true
        return scroolView
    }()
    
    private let productImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        return sv
    }()
    
    private let titleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
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
        label.font = UIFont.systemFont(ofSize: 20)
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
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let productDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle(Constants.Properties.Add_To_Basket, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: Properties
    
    private var viewModel: DetailViewModel?
    
    // MARK: Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        activeIndicator()
        noResult.isHidden = true
  
        viewModel?.output = self
        
        setUpView()
        setUpConstraint()
    }

    // MARK: Func
    
    func activeIndicator() {
        productImage.isHidden = true
        verticalStack.isHidden = true
        addButton.isHidden = true
    }
    
    func passiveIndicator() {
        productImage.isHidden = false
        verticalStack.isHidden = false
        addButton.isHidden = false
    }
    
    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(indicator)
        view.addSubview(noResult)
        view.addSubview(scroolView)
        scroolView.addSubview(productImage)
        scroolView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleName)
        verticalStack.addArrangedSubview(price)
        verticalStack.addArrangedSubview(campaignPrice)
        verticalStack.addArrangedSubview(productDescription)
        view.addSubview(addButton)
    }
    
    func configureProduct(product: Detail) {
        
        self.productImage.af.setImage(withURL: URL(string: (product.featuredImage?.t)!)!)
        self.titleName.text = product.title
        self.price.text = Constants.Properties.Price + "\(product.price!)"
        
        if product.campaignPrice == nil {
            campaignPrice.removeFromSuperview()
        } else {
            self.campaignPrice.text = Constants.Properties.Campaing_Price + "\(product.campaignPrice ?? 0)"
        }
        
        self.productDescription.attributedText = product.dataDescription?.htmlToAttributedString
    }
    
    func setUpConstraint() {
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        noResult.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        scroolView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.bottom.equalTo(addButton.snp.top).offset(-5)
        }
        
        productImage.snp.makeConstraints { make in
            make.top.equalTo(scroolView.snp.top)
            make.left.equalTo(scroolView).offset(10)
            make.right.equalTo(scroolView).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(300)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.left.equalTo(scroolView).offset(10)
            make.right.equalTo(scroolView).offset(-10)
            make.bottom.equalTo(scroolView).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        titleName.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.top).offset(5)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(titleName.snp.bottom).offset(10)
        }
        
        campaignPrice.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(10)
        }
        
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(campaignPrice.snp.bottom).offset(20)
            make.bottom.equalTo(verticalStack.snp.bottom).offset(-10)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(scroolView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
        }
    }
}

// MARK: Extension

extension DetailViewController: DetailViewModelOutput {
    
    func selectProduct(product: Detail?) {
        configureProduct(product: product!)
        indicator.stopAnimating()
        passiveIndicator()
    }
    
    func noResults() {
        indicator.stopAnimating()
        noResult.isHidden = false
        activeIndicator()
        noResult.text = Constants.Properties.No_Result
    }
}
