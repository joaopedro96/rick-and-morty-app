//
//  RMEpisodesListHeaderSectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

protocol RMEpisodesListHeaderSectionViewDelegate: AnyObject {
    func didTapCell()
}

final class RMEpisodesListHeaderSectionView: UIView {
    
    // MARK: - CONSTANTS
    
    private enum Metrics {
        static let screenWidth = UIScreen.main.bounds.width
        static let tableViewRelativeCellHeight: CGFloat = 0.25
    }
    
    // MARK: - PROPERTIES
    
    weak var delegate: RMEpisodesListHeaderSectionViewDelegate?
    private var episodeListData: [RMEpisodeDetailResponse] = []
    var shouldShowLoading = false {
        didSet {
            setFooterView(for: shouldShowLoading)
        }
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
    
    private lazy var episodeTableView: RMDynamicHeightTableView = {
        let setupComponent = RMDynamicHeightTableView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.register(RMEpisodesListTableViewCell.self, forCellReuseIdentifier: RMEpisodesListTableViewCell.identifier)
        setupComponent.showsVerticalScrollIndicator = false
        setupComponent.allowsSelection = true
        setupComponent.separatorColor = .clear
        setupComponent.backgroundColor = .clear
        setupComponent.dataSource = self
        setupComponent.delegate = self
        setupComponent.isScrollEnabled = false
        return setupComponent
    }()
    
    private func createSpinnerFooter() -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 48
        let spinnerFooter = CGRect(x: 0, y: 0, width: screenWidth, height: 100)
        let footerView = UIView(frame: spinnerFooter)
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    // MARK: - PUBLIC METHODS
    
    func updateSection(with data: RMEpisodeListResponse) {
        episodeListData.append(contentsOf: data.results)
        episodeTableView.reloadData()
    }
    
    func updateEpisodeNextPage(with data: RMEpisodeListResponse) {
        guard let indexPathArray = getIndexPathArray(for: data.results) else { return }
        episodeTableView.performBatchUpdates {
            self.episodeTableView.insertRows(at: indexPathArray, with: .automatic)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setFooterView(for state: Bool) {
        if state {
            episodeTableView.tableFooterView = createSpinnerFooter()
        } else {
            episodeTableView.tableFooterView = nil
        }
    }
    
    private func getIndexPathArray(for newData: [RMEpisodeDetailResponse]) -> [IndexPath]? {
        let currentIndex = episodeListData.count
        episodeListData.append(contentsOf: newData)
        let newCount = episodeListData.count
        var indexPathArray: [IndexPath] = []
        
        for index in currentIndex ..< newCount {
            indexPathArray.append(IndexPath(row: index, section: 0))
        }
        
        return indexPathArray
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(episodeTableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeTableView.topAnchor.constraint(equalTo: topAnchor),
            episodeTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            episodeTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            episodeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - EXTENSIONS

extension RMEpisodesListHeaderSectionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeListData.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 12
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 12
        maskLayer.backgroundColor = UIColor.lightGray.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RMEpisodesListTableViewCell.identifier, for: indexPath)
        guard let episodeCell = cell as? RMEpisodesListTableViewCell else { return cell }
        episodeCell.updateCell(with: episodeListData[indexPath.row])
        return episodeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.screenWidth * Metrics.tableViewRelativeCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapCell()
    }
}
