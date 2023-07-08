//
//  RMBottomSheetView.swift
//  RickAndMorty
//
//  Created by João Pedro Mata on 18/06/23.
//

import UIKit

enum TestBottomShitEvents: BottomSheetEvents {    
    case didTapOkButton
}

protocol TestBottomShitViewDelegate: AnyObject {
    func didTapButton(from floatPanel: UIViewController?)
}

class TestBottomShitView: UIView, RMBottomSheetViewProtocol {
    
    weak var delegate: RMBottomSheetViewControllerDelegateProtocol?
            
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        setupComponent.spacing = 4
        return setupComponent
    }()
    
    private lazy var sectionTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .green200
        setupComponent.text = "TEXTO"
        return setupComponent
    }()
    
    private lazy var offerTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        setupComponent.text = "TEXTO"
        return setupComponent
    }()
    
    private lazy var offerTitle2: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        setupComponent.text = "TEXTO"
        return setupComponent
    }()
    
    private lazy var offerTitle3: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .black
        setupComponent.text = "TEXTO"
        return setupComponent
    }()
    
    private lazy var backButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 8
        setupComponent.setTitle("Back", for: .normal)
        setupComponent.backgroundColor = .systemBlue
        setupComponent.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapButton() {
        delegate?.didTrigger(event: TestBottomShitEvents.didTapOkButton)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        backgroundColor = .gray200
    }
    
    private func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(sectionTitle, offerTitle, offerTitle2, offerTitle3, backButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
}



// MARK: - TEST BOTTOM SHEET 2

protocol TestBottomShitView2Delegate: AnyObject {
    func didTapButtonDale(from floatPanel: UIViewController?)
}

enum TestBottomShit2Events: BottomSheetEvents {
    case didTapDaleButton
}

class TestBottomShitView2: UIView, RMBottomSheetViewProtocol {
    
    weak var delegate: RMBottomSheetViewControllerDelegateProtocol?
    
    // MARK: - INITIALIZER
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        setupComponent.spacing = 4
        return setupComponent
    }()
    
    private lazy var sectionTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 12, weight: .regular)
        setupComponent.textColor = .green200
        setupComponent.text = "TITLE"
        return setupComponent
    }()
    
    private lazy var offerTitle: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        setupComponent.text = "TITLE"
        return setupComponent
    }()
    
    private lazy var offerTitle2: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .gray500
        setupComponent.text = "TITLE"
        return setupComponent
    }()
    
    private lazy var offerTitle3: UILabel = {
        let setupComponent = UILabel()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 24, weight: .bold)
        setupComponent.textColor = .black
        setupComponent.text = "TITLE"
        return setupComponent
    }()
    
    private lazy var backButton: UIButton = {
        let setupComponent = UIButton(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 8
        setupComponent.setTitle("Back", for: .normal)
        setupComponent.backgroundColor = .systemBlue
        setupComponent.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return setupComponent
    }()
    
    // MARK: - PRIVATE METHODS
    
    @objc private func didTapButton() {
        delegate?.didTrigger(event: TestBottomShit2Events.didTapDaleButton)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        backgroundColor = .gray200
    }
    
    private func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(sectionTitle, offerTitle, offerTitle2, offerTitle3, backButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
}
