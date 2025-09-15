//
//  NumberDetailViewController.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import UIKit

final class NumberDetailViewController: UIViewController {
    
    // MARK: - Private Variables
    private var containerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private let offsetBetweenViews = 16
    
    // MARK: - Public Variables
    var viewModel: NumberDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        
        self.view.addSubview(containerView)
        [numberLabel, descriptionNumberLabel].forEach({containerView.addSubview($0)})
        
        containerView.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
        })
        
        
        numberLabel.snp.makeConstraints({ make in
            make.top.leading.trailing.equalToSuperview()
        })
        
        descriptionNumberLabel.snp.makeConstraints({ make in
            make.top.equalTo(numberLabel.snp.bottom).offset(offsetBetweenViews)
            make.leading.trailing.bottom.equalToSuperview()
        })
        
        configurateView()
    }
    
    private func configurateView() {
        numberLabel.text = viewModel.model.title
        descriptionNumberLabel.text = viewModel.model.descriptionNumber
    }
}
