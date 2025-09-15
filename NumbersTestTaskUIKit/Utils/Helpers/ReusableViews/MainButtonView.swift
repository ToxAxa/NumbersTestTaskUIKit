//
//  MainButtonView.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit
import SnapKit

final class MainButtonView: UIControl {

    // MARK: - Private Variables
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        
        return view
    }()
    
    // MARK: - Public Variables
    var didTapButton: Action?
    
    var type: ButtonType = .empty {
        didSet {
            prepareWithType(type)
        }
    }
    
    var isEnabledButton = true {
        didSet {
            if isEnabledButton {
                self.alpha = 1.0
                self.isUserInteractionEnabled = true
            } else {
                self.alpha = 0.5
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    enum ButtonType {
        case empty
        case mainAccent(title: String?)
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareMainButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareMainButton()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: - Private Methods
    private func prepareMainButton() {
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
            make.height.equalTo(32)
        })
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.centerY.centerX.equalToSuperview()
        })
        
        prepareWithType(type)
    }
    
    private func prepareWithType(_ type: ButtonType) {
        switch type {
        case .empty:
            break
        case let .mainAccent(title):
            containerView.backgroundColor = .blueButtonBackgroundColor
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = .white
            titleLabel.text = title
            containerView.cornerRadius = 16
        }
    }
}


// MARK: - UIControl events
extension MainButtonView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05) {
            switch self.type {
            case .mainAccent:
                self.containerView.backgroundColor = .blueButtonBackgroundColor.withAlphaComponent(0.7)
            case .empty:
                self.containerView.backgroundColor = .clear
            }
        }

        return super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05) { [weak self] in
            guard let strongSelf = self else { return }
            switch strongSelf.type {
            case .mainAccent:
                strongSelf.containerView.backgroundColor = .blueButtonBackgroundColor
                
            case .empty:
                strongSelf.containerView.backgroundColor = .clear
            }
        }
        didTapButton?()
        return super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05) { [weak self] in
            guard let strongSelf = self else { return }
            switch strongSelf.type {
            case .mainAccent:
                strongSelf.containerView.backgroundColor = .blueButtonBackgroundColor
                
            case .empty:
                strongSelf.containerView.backgroundColor = .clear
            }
        }
        return super.touchesCancelled(touches, with: event)
    }
}
