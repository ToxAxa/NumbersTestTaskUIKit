//
//  MainViewModel.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import Foundation

enum TypeOfNumber {
    case none
    case enteredNumber
    case randomNumber
}

protocol MainViewModelProtocol {
    init(requestService: NumbersServiceAPIProtocol, coreDataService: CoreDataService)
    func createQueryByNumber(with type: TypeOfNumber, completion: @escaping BoolAction)
    func clearHistoryNumber()
    func fetchNumbersData(completion: @escaping Action)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> NumberCellViewModelProtocol
    func saveNumber(completion: @escaping Action)
    func showDetailScreen()
}

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Private Properties
    private let requestService: NumbersServiceAPIProtocol
    private let coreDataService: CoreDataService
    
    // MARK: - Initialization
    init(requestService: NumbersServiceAPIProtocol, coreDataService: CoreDataService) {
        self.requestService = requestService
        self.coreDataService = coreDataService
    }
    
    // MARK: - Public Properties
    var currentNumber: Int?
    var numberInfo: NumberInfoModel?
    var dataArray: [NumberInfoData] = []
    var chosenIndexPath: IndexPath?
    var showNumberDetailScreenAction: ShowDetailScreenAction?
    
    // MARK: - Private Methods
    private func fetchNumberRequest(completion: @escaping BoolAction) {
        guard let number = currentNumber else {return}
        
        requestService.fetchNumberInfo(number: number) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let numberInfo):
                    self.createNumberInfoModel(from: numberInfo.numberDescription)
                    completion(true)
                case .failure(let errorString):
                    print(errorString.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    private func fetchRandomNumberRequest(completion: @escaping BoolAction) {
        requestService.fetchRandomNumberInfo() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let numberInfo):
                    self.createNumberInfoModel(from: numberInfo.numberDescription)
                    completion(true)
                case .failure(let errorString):
                    print(errorString.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    private func createNumberInfoModel(from text: String) {
        if let index = text.firstIndex(of: " ") {
            let number = text.prefix(upTo: index)
            let description = text[index...].dropFirst()
            
            numberInfo = NumberInfoModel(id: UUID().uuidString, number: String(number), description: String(description))
        }
    }
    
    
    // MARK: - Public Methods
    func createQueryByNumber(with type: TypeOfNumber, completion: @escaping BoolAction) {

        switch type {
        case .none:
            break
        case .enteredNumber:
            fetchNumberRequest(completion: completion)
        case .randomNumber:
            fetchRandomNumberRequest(completion: completion)
        }
    }
    
    func clearHistoryNumber() {
        currentNumber = nil
    }
    
    func fetchNumbersData(completion: @escaping Action) {
        dataArray = coreDataService.retrieveAllnumbers().reversed()
        completion()
    }
    
    func numberOfRows() -> Int {
        dataArray.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> NumberCellViewModelProtocol {
        let model = dataArray[indexPath.row]
        return NumberCellViewModel(model: model)
    }
    
    func saveNumber(completion: @escaping Action) {
        guard let model = numberInfo else {return}
        
        coreDataService.saveNumber(from: model) {
            completion()
        }
    }
    
    func showDetailScreen() {
        guard let index = chosenIndexPath?.row else {return}
        let model = dataArray[index]
        
        showNumberDetailScreenAction?(model)
    }
    
}

