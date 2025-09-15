//
//  MainViewController.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    
    // MARK: - Private Variables
    private var containerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
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
    
    private let getFactButton: MainButtonView = {
        let button = MainButtonView()
        button.type = .mainAccent(title: "Отримати факт")
        button.isEnabledButton = false
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let randomNumberButton: MainButtonView = {
        let button = MainButtonView()
        button.type = .mainAccent(title: "Отримати факт про випадкове число")
        
        return button
    }()
    
    private let mainTextField: MainTextField = {
        let textFiled = MainTextField()
        textFiled.type = .inputWithPlaceholderText(placeholderText: "Enter Number")
        
        return textFiled
    }()
    
    private let offsetBetweenViews: CGFloat = 16
    
    // MARK: - Public Variables
    var viewModel: MainViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchNumberData()
    }
    
    deinit {
        
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        
        self.view.addSubview(containerView)
        [mainStackView, numberLabel, descriptionNumberLabel, tableView].forEach({containerView.addSubview($0)})
        
        containerView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(topSafeAreaHeight + offsetBetweenViews)
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
            make.bottom.equalToSuperview().inset(bottomSafeAreaHeight)
        })
        
        mainStackView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(offsetBetweenViews)
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
        })
        
        mainStackView.addArrangedSubview(mainTextField)
        mainStackView.addArrangedSubview(getFactButton)
        mainStackView.addArrangedSubview(randomNumberButton)
        
        numberLabel.snp.makeConstraints({ make in
            make.top.equalTo(mainStackView.snp.bottom).offset(offsetBetweenViews * 2)
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
        })
        
        descriptionNumberLabel.snp.makeConstraints({ make in
            make.top.equalTo(numberLabel.snp.bottom).offset(offsetBetweenViews)
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
        })
        
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(descriptionNumberLabel.snp.bottom).offset(offsetBetweenViews * 4)
            make.leading.equalToSuperview().offset(offsetBetweenViews)
            make.trailing.equalToSuperview().inset(offsetBetweenViews)
            make.bottom.equalToSuperview()
        })
        
        setupActions()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(NumberTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NumberTableViewCell.self))

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func fetchNumberData() {
        viewModel.fetchNumbersData() { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func setupActions() {
        
        getFactButton.didTapButton = { [weak self] in
            guard let self = self else { return }
            
            self.getFactButton.isEnabledButton = false
            self.fetchNumberInfo(type: .enteredNumber)
        }
        
        randomNumberButton.didTapButton = { [weak self] in
            guard let self = self else { return }
            
            self.getFactButton.isEnabledButton = false
            self.fetchNumberInfo(type: .randomNumber)
        }
        
        mainTextField.textDidChangeAction = { [weak self] number in
            guard let self = self else { return }
            
            self.getFactButton.isEnabledButton = true
            self.viewModel.currentNumber = number
        }
        
        mainTextField.notNumberAction = { [weak self] in
            guard let self = self else { return }
            
            self.getFactButton.isEnabledButton = false
        }
    }
    
    private func fetchNumberInfo(type: TypeOfNumber) {
        viewModel.createQueryByNumber(with: type) { [weak self] isSuccess in
            guard let self = self else { return }
            
            if isSuccess {
                self.showNumberInfo()
                self.saveToCoreData()
            } else {
                //Some Alert
            }

            self.viewModel.clearHistoryNumber()
            self.mainTextField.clearTextField()
        }
    }
    
    private func saveToCoreData() {
        viewModel.saveNumber { [weak self] in
            guard let self = self else { return }
            self.fetchNumberData()
        }
    }
    
    private func showNumberInfo() {
        numberLabel.text = viewModel.numberInfo?.number
        descriptionNumberLabel.text = viewModel.numberInfo?.description
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NumberTableViewCell.self), for: indexPath) as? NumberTableViewCell
        else {return UITableViewCell()}
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        cell.selectionStyle = .none
        
        cell.cellDidTapAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.chosenIndexPath = indexPath
            self.viewModel.showDetailScreen()
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
}
