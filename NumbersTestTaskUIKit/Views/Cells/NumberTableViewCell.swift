//
//  NumberTableViewCell.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import UIKit

class NumberTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    private var mainContainerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        
        return label
    }()
    
    var cellDidTapAction: Action?
    private let offsetBetweenViews = 16
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Variables
    var viewModel: NumberCellViewModelProtocol? {
        didSet {
            guard let model = viewModel else {return}
            titleTextLabel.text = model.titleNumber
            descriptionTextLabel.text = model.descriptionNumber
        }
    }
    
    // MARK: - Private methods
    private func prepareStyle() {
        self.backgroundColor = .clear
        self.contentView.addSubview(mainContainerView)
        
        [titleTextLabel, descriptionTextLabel].forEach({mainContainerView.addSubview($0)})
        
        mainContainerView.snp.makeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
        
        
        titleTextLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(offsetBetweenViews)
            make.leading.trailing.equalToSuperview()
        })
        
        descriptionTextLabel.snp.makeConstraints({ make in
            make.top.equalTo(titleTextLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(offsetBetweenViews)
        })
        
        setupActions()
    }

    private func setupActions() {
        mainContainerView.addTapGR(completion: { [weak self] _ in
            guard let self = self else { return }
            cellDidTapAction?()
        })
    }
}
