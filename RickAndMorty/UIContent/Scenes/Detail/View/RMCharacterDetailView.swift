//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMCharacterDetailView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: RMCharacterDetailViewDelegate?
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let setupComponent = UIScrollView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.contentInsetAdjustmentBehavior = .never
        setupComponent.bounces = true
        setupComponent.scrollsToTop = true
        setupComponent.showsVerticalScrollIndicator = false
        return setupComponent
    }()
    
    private lazy var containerStackView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        setupComponent.distribution = .fill
        return setupComponent
    }()
    
    private lazy var headerSectionView: RMCharacterDetailHeaderSectionView = {
        let setupComponent = RMCharacterDetailHeaderSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    private lazy var bodySectionView: RMCharacterDetailBodySectionView = {
        let setupComponent = RMCharacterDetailBodySectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    private lazy var footerSectionView: RMCharacterDetaiFooterSectionView = {
        let setupComponent = RMCharacterDetaiFooterSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.delegate = self
        return setupComponent
    }()
    
    
    // MARK: - PRIVATE METHODS
    
    private func updateView(with data: RMCharacterDetailResponse) {
        headerSectionView.updateSection(with: data)
        bodySectionView.updateSection(with: data)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubviews(headerSectionView,
                                               bodySectionView,
                                               footerSectionView)
    }
    
    private func addConstraints() {
        let containerStackViewHeightConstraint = containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
        containerStackViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: widthAnchor),
            containerStackViewHeightConstraint
        ])
    }
    
    private func customizeView() {
        backgroundColor = .white
    }
}

// MARK: - EXTENSIONS

extension RMCharacterDetailView: RMCharacterDetailViewProtocol {
    func updateState(with viewState: RMCharacterDetailViewState) {
        switch viewState {
            case .hasData(let data):
                updateView(with: data)
            default: return
        }
    }
}

extension RMCharacterDetailView: RMCharacterDetaiFooterSectionViewDelegate {
    func didTapButton() {
        delegate?.didTapBackButton()
    }
}
