//
//  RMCharacterListViewController.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import UIKit
import RxSwift

final class RMCharacterListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let disposeBag = DisposeBag()
    private let viewModel: RMCharacterListViewModelProtocol
    private let contentView: RMCharacterListViewProtocol
    weak var delegate: RMCharacterListViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    init(contentView: RMCharacterListViewProtocol = RMCharacterListView(),
         viewModel: RMCharacterListViewModelProtocol) {
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
        bindObservables()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        title = "Characters"
        view = contentView.content
        contentView.delegate = self
    }
    
    private func bindObservables() {
        viewModel.viewState.subscribe(onNext: { [weak self] state in
            self?.contentView.updateState(with: state)
        }).disposed(by: disposeBag)
    }
}

// MARK: - EXTENSIONS

extension RMCharacterListViewController: RMCharacterListViewDelegate {
    func getNextPage(with url: String) {
        viewModel.getNextPageData(with: url)
    }
    
    func didTapCharacter(_ selectedCharacter: RMCharacterDetailResponse) {
        guard let tabIndex = navigationController?.tabBarItem.tag else { return }
        delegate?.goToCharacterDetailPage(with: selectedCharacter, from: tabIndex)
    }
}
