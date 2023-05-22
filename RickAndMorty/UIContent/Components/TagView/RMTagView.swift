//
//  RMTagView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMTagView: UIView {
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var tagLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func setTag(with textColor: UIColor?, tagColor: UIColor?, tagText: String?) {
        tagLabel.text = tagText
        tagLabel.textColor = textColor
        backgroundColor = tagColor
    }

    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubview(tagLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    private func customizeView() {
        layer.cornerRadius = 8
    }
}
