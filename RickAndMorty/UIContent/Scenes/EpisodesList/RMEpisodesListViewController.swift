//
//  RMEpisodesListViewController.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import UIKit

final class RMEpisodesListViewController: UIViewController {

    // MARK: - PROPERTIES

    private let viewModel: RMEpisodesListViewModelProtocol
    private let contentView: RMEpisodesListViewProtocol
    weak var delegate: RMEpisodesListViewControllerDelegate?

    // MARK: - INITIALIZERS

    init(contentView: RMEpisodesListViewProtocol = RMEpisodesListView(),
         viewModel: RMEpisodesListViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initState()
        setupController()
    }

    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        title = "Episodes"
        view = contentView.content
        contentView.delegate = self
    }
}

// MARK: - EXTENSIONS

extension RMEpisodesListViewController: RMEpisodesListViewControllerProtocol {
    func updateState(with viewState: RMEpisodesListViewState) {
        contentView.updateState(with: viewState)
    }
}

extension RMEpisodesListViewController: RMEpisodesListViewDelegate {
    func getNextPage(with url: String) {
        viewModel.getNextPageData(with: url)
    }
    
    func didTapEpisodeCell() {
        guard let tabIndex = navigationController?.tabBarItem.tag else { return }
        delegate?.goToEpisodeDetailPage(from: tabIndex)
    }
}
