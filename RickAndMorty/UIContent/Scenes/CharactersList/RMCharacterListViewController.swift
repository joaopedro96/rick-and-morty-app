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
//        guard let tabIndex = navigationController?.tabBarItem.tag else { return }
//        delegate?.goToCharacterDetailPage(with: selectedCharacter, from: tabIndex)
        goToBottomSheet2()
    }
    
    func goToBottomSheet() {
        let view = TestBottomShitView()
        let fpc = RMBottomSheetViewController(contentView: view)
        fpc.bottomSheetDelegate = self
        present(fpc, animated: true, completion: nil)
    }
    
    func goToBottomSheet2() {
        let view = TestBottomShitView2()
        let fpc = RMBottomSheetViewController(contentView: view)
        fpc.bottomSheetDelegate = self
        fpc.didTapBackDrop = { panelController in
            print("safe")
            panelController.dismiss(animated: true)
        }
        
        present(fpc, animated: true, completion: nil)
    }
}

extension RMCharacterListViewController: BottomSheetDelegate {
    func sendEvent(from floatPanel: UIViewController, and event: any BottomSheetEvents) {
        
        switch event {
            case let newEvent as TestBottomShitEvents:
                executeBottomSheetEvent(for: newEvent, and: floatPanel)
                
            case let newEvent as TestBottomShit2Events:
                executeBottomSheet2Event(for: newEvent, and: floatPanel)
                
            default: return
        }
    }
    
    private func executeBottomSheetEvent(for event: TestBottomShitEvents, and floatPanel: UIViewController) {
        switch event {
            case .didTapOkButton:
                print("ok")
                floatPanel.dismiss(animated: true)
        }
    }
    
    private func executeBottomSheet2Event(for event: TestBottomShit2Events, and floatPanel: UIViewController) {
        switch event {
            case .didTapDaleButton:
                print("dale")
                floatPanel.dismiss(animated: true)
        }
    }
}
