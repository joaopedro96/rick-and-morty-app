//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMCharacterListView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: RMCharacterListViewDelegate?
    private var nextPageUrl: String?
    
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
        setupComponent.delegate = self
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
    
    private lazy var spinner: UIActivityIndicatorView = {
        let setupComponent = UIActivityIndicatorView(style: .large)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        setupComponent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return setupComponent
    }()
    
    private lazy var headerSectionView: RMCharacterListHeaderSectionView = {
        let setupComponent = RMCharacterListHeaderSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.isHidden = true
        setupComponent.alpha = 0
        return setupComponent
    }()
    
    private lazy var bodySectionView: RMCharacterListBodySectionView = {
        let setupComponent = RMCharacterListBodySectionView()
        setupComponent.delegate = self
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.isUserInteractionEnabled = true
        setupComponent.alpha = 0
        setupComponent.isHidden = true
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func updateView(with data: RMCharacterListResponse) {
        nextPageUrl = data.info.next
        bodySectionView.updateSection(with: data)
    }
    
    private func updateCharacterNextPage(with data: RMCharacterListResponse) {
        bodySectionView.shouldShowLoading = false
        nextPageUrl = data.info.next
        bodySectionView.updateCharacterNextPage(with: data)
    }
    
    private func prepareViewToShowData() {
        spinner.stopAnimating()
        headerSectionView.isHidden = false
        bodySectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.headerSectionView.alpha = 1
            self.bodySectionView.alpha = 1
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubviews(containerStackView, spinner)
        containerStackView.addArrangedSubviews(headerSectionView, bodySectionView)
    }
    
    private func addConstraints() {
        let containerStackViewHeightConstraint = containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
        containerStackViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: widthAnchor),
            containerStackViewHeightConstraint
        ])
    }
}

// MARK: - EXTENSIONS

extension RMCharacterListView: RMCharacterListViewProtocol {
    
    func updateState(with viewState: RMCharacterListViewState) {
        switch viewState {
            case .hasData(let data):
                prepareViewToShowData()
                updateView(with: data)
            case .hasNextPageData(let data):
                updateCharacterNextPage(with: data)
            case .isLoading:
                spinner.startAnimating()
            case .hasError:
                spinner.stopAnimating()
                bodySectionView.shouldShowLoading = false
            default: return
        }
    }
}

extension RMCharacterListView: RMCharacterListBodySectionViewDelegate {
    func didTapCharacter(_ characterData: RMCharacterDetailResponse) {
        delegate?.didTapCharacter(characterData)
    }
}

extension RMCharacterListView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > (containerStackView.frame.height + 100 - scrollView.frame.size.height) {
            guard let nextPageUrl = nextPageUrl else { return }
            bodySectionView.shouldShowLoading = true
            delegate?.getNextPage(with: nextPageUrl)
        }
    }
}
