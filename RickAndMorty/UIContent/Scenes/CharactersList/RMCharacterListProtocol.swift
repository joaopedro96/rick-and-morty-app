//
//  RMCharacterListViewProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit
import RxSwift

protocol RMCharacterListViewModelProtocol: AnyObject {
    var viewState: BehaviorSubject<RMCharacterListViewState> { get }
    func initState()
    func getNextPageData(with url: String)
}

protocol RMCharacterListViewControllerDelegate: AnyObject {
    func goToCharacterDetailPage(with characterData: RMCharacterDetailResponse, from tabIndex: Int)
}
