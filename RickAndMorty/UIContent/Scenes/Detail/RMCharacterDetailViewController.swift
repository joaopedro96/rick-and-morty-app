//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let viewModel: RMCharacterDetailViewModelProtocol
    private let contentView: RMCharacterDetailViewProtocol
    weak var delegate: RMCharacterDetailViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    init(contentView: RMCharacterDetailViewProtocol = RMCharacterDetailView(),
         viewModel: RMCharacterDetailViewModelProtocol) {
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
        title = "Detail"
        view = contentView.content
        contentView.delegate = self
    }
}

// MARK: - EXTENSIONS

extension RMCharacterDetailViewController: RMCharacterDetailViewControllerProtocol {
    func updateState(with viewState: RMCharacterDetailViewState) {
        contentView.updateState(with: viewState)
    }
}

extension RMCharacterDetailViewController: RMCharacterDetailViewDelegate {
    func didTapBackButton() {
        guard let tabIndex = navigationController?.tabBarItem.tag else { return }
        delegate?.didTapGoBack(from: tabIndex)
    }
}
