//
//  RMCharacterListFooterReusableView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMCharacterListFooterReusableView: UICollectionReusableView {
    
    // MARK: - PROPERTIES
    
    static let identifier = "RMCharacterListFooterReusableView"
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var spinner: UIActivityIndicatorView = {
        let setupComponent = UIActivityIndicatorView(style: .large)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS

    func startAnimating() {
        spinner.startAnimating()
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(spinner)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: topAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
