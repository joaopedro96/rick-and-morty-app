//
//  RMCharacterDetaiFooterSectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMCharacterDetaiFooterSectionViewDelegate: AnyObject {
    func didTapButton()
}

final class RMCharacterDetaiFooterSectionView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: RMCharacterDetaiFooterSectionViewDelegate?
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var backButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 8
        setupComponent.setTitle("Back", for: .normal)
        setupComponent.backgroundColor = .systemBlue
        setupComponent.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapButton() {
        delegate?.didTapButton()
    }

    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(backButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
