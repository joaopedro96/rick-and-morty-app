//
//  RMCharacterListHeaderSectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMCharacterListHeaderSectionView: UIView {
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var image: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.image = .headerIcon
        return setupComponent
    }()
    
    private lazy var title: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.text = "API provided by rickandmortyapi.com"
        setupComponent.font = .systemFont(ofSize: 12, weight: .bold)
        setupComponent.textColor = .gray400
        setupComponent.textAlignment = .center
        return setupComponent
    }()
    
    private lazy var lineView: UIView = {
        let setupComponent = UIView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .gray200
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapHeader() {
        if let url = URL(string: "https://www.rickandmortyapi.com") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubviews(image, title, lineView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            lineView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func customizeView() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
}
