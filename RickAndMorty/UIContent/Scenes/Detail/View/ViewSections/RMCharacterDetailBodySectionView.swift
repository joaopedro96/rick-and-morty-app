//
//  RMCharacterDetailBodySectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMCharacterDetailBodySectionView: UIView {
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        setupComponent.distribution = .fill
        setupComponent.spacing = 8
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateSection(with data: RMCharacterDetailResponse) {
        let array = getTupleArray(with: data)
        populateStackView(with: array)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getTupleArray(with data: RMCharacterDetailResponse) -> [(String, String)] {
        let tupleArray: [(String, String)] = [
            ("Status:", data.status.rawValue),
            ("Species:", data.species),
            ("Gender:", data.gender.rawValue),
            ("Origin:", data.origin.name),
            ("Last location:", data.location.name),
        ]
        return tupleArray
    }
    
    private func populateStackView(with tupleArray: [(key: String, value: String)]) {
        tupleArray.forEach { tuple in
            let label = RMParallelLabel(titleText: tuple.key, descriptionText: tuple.value)
            stackView.addArrangedSubviews(label)
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
