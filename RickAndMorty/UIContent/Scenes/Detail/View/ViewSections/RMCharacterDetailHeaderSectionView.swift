//
//  RMCharacterDetailHeaderSectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMCharacterDetailHeaderSectionView: UIView {
    
    private enum Metrics {
        static let screenWidth = UIScreen.main.bounds.width
        static let posterImageRelativeHeight = 1 * screenWidth
        static let gradientEffectSize: CGRect = CGRect(x: 0, y: 0,
                                                       width: screenWidth,
                                                       height: posterImageRelativeHeight)
    }
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var posterView: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .gray300
        setupComponent.alpha = 0.9
        setupComponent.contentMode = .scaleToFill
        setupComponent.clipsToBounds = true
        setupComponent.isUserInteractionEnabled = true
        return setupComponent
    }()
    
    private lazy var posterViewGradientEffect: UIView = {
        let setupComponent = UIView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        let gradient = CAGradientLayer()
        gradient.frame = Metrics.gradientEffectSize
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.5, 1.0]
        setupComponent.layer.insertSublayer(gradient, at: 0)
        return setupComponent
    }()
    
    private lazy var titleLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.textColor = .gray500
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textAlignment = .center
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    public func updateSection(with data: RMCharacterDetailResponse) {
        titleLabel.text = data.name
        updateCellPosterView(with: data.image)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func updateCellPosterView(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            guard let loadedImage = data else { return }
            DispatchQueue.main.async {
                if data != nil { self.posterView.image = UIImage(data: loadedImage) }
            }
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(posterView, titleLabel)
        posterView.addSubview(posterViewGradientEffect)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: topAnchor),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: Metrics.posterImageRelativeHeight),
            
            posterViewGradientEffect.topAnchor.constraint(equalTo: posterView.topAnchor),
            posterViewGradientEffect.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            posterViewGradientEffect.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            posterViewGradientEffect.bottomAnchor.constraint(equalTo: posterView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
