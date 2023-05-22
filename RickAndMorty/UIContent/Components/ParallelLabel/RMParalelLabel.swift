//
//  RMParallelLabel.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMParallelLabel: UIView {
    
    // MARK: - PROPERTIES
    
    let titleText: String
    let descriptionText: String
    
    // MARK: - INITIALIZER
    
    init(titleText: String, descriptionText: String) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.text = titleText
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 16, weight: .bold)
        setupComponent.textColor = .gray500
        setupComponent.setContentCompressionResistancePriority(.required, for: .horizontal)
        return setupComponent
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.text = descriptionText
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 16, weight: .regular)
        setupComponent.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        setupComponent.textColor = .gray400
        return setupComponent
    }()
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(titleLabel, descriptionLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
