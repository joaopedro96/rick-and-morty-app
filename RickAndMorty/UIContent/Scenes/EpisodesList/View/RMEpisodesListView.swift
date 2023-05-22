//
//  RMEpisodesListView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMEpisodesListView: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: RMEpisodesListViewDelegate?
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
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.delegate = self
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
    
    private lazy var headerSectionView: RMEpisodesListHeaderSectionView = {
        let setupComponent = RMEpisodesListHeaderSectionView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.delegate = self
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func updateView(with data: RMEpisodeListResponse) {
        nextPageUrl = data.info.next
        headerSectionView.updateSection(with: data)
    }
    
    private func updateEpisodeNextPage(with data: RMEpisodeListResponse) {
        headerSectionView.shouldShowLoading = false
        nextPageUrl = data.info.next
        headerSectionView.updateEpisodeNextPage(with: data)
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
        containerStackView.addArrangedSubview(headerSectionView)
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

extension RMEpisodesListView: RMEpisodesListViewProtocol {
    func updateState(with viewState: RMEpisodesListViewState) {
        switch viewState {
            case .hasData(let data):
                updateView(with: data)
            case .hasNextPageData(let data):
                updateEpisodeNextPage(with: data)
            default: return
        }
    }
}

extension RMEpisodesListView: RMEpisodesListHeaderSectionViewDelegate {
    func didTapCell() {
        delegate?.didTapEpisodeCell()
    }
}

extension RMEpisodesListView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > (containerStackView.frame.height + 100 - scrollView.frame.size.height) {
            guard let nextPageUrl = nextPageUrl else { return }
            headerSectionView.shouldShowLoading = true
            delegate?.getNextPage(with: nextPageUrl)
        }
    }
}
