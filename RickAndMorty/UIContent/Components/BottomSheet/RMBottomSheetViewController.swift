//
//  RMBottomSheetViewController.swift
//  RickAndMorty
//
//  Created by João Pedro Mata on 18/06/23.
//

import Foundation
import FloatingPanel

protocol BottomSheetEvents { }

protocol RMBottomSheetViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: RMBottomSheetViewControllerDelegateProtocol? { get set }
}

extension RMBottomSheetViewProtocol where Self: UIView {
    var content: UIView { return self }
}

protocol BottomSheetDelegate: AnyObject {
    func sendEvent(from floatPanel: UIViewController, and event: BottomSheetEvents)
}

protocol RMBottomSheetViewControllerDelegateProtocol: AnyObject {
    func didTrigger(event: BottomSheetEvents)
}

final class RMBottomSheetViewController: FloatingPanelController {
    
    let contentView: RMBottomSheetViewProtocol

    private var size: CGFloat = 0

    var didTapBackDrop: ((UIViewController) -> Void)?
    
    weak var bottomSheetDelegate: BottomSheetDelegate?
    
    init(contentView: RMBottomSheetViewProtocol) {
        self.contentView = contentView
        super.init()
        setupFloatingPanel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFloatingPanel() {
        changePanelStyle()
        delegate = self
        contentView.delegate = self
        contentInsetAdjustmentBehavior = .never
        backdropView.dismissalTapGestureRecognizer.isEnabled = true
        isRemovalInteractionEnabled = true
        setContentView()
    }
    
    private func setContentView() {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(contentView.content)
        stackView.layoutIfNeeded()
        size = stackView.frame.height
        
        let contentVC = UIViewController()
        contentVC.view = stackView
        set(contentViewController: contentVC)
        
        backdropView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackView)))
    }
    
    @objc private func didTapBackView() {
        dismiss(animated: true)
        didTapBackDrop?(self)
    }
    
    private func changePanelStyle() {
        surfaceView.shadowColor = UIColor.black
        surfaceView.shadowOffset = CGSize(width: 0, height: -2.0)
        surfaceView.shadowOpacity = 0.15
        surfaceView.shadowRadius = 2
        surfaceView.cornerRadius = 15.0
        surfaceView.backgroundColor = .clear
        surfaceView.borderColor = .clear
        surfaceView.borderWidth = 0
        surfaceView.cornerRadius = 12
    }
}

extension RMBottomSheetViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        let layout = KBFloatingPanelLayout(contentHeight: size)
        return layout
    }
}

extension RMBottomSheetViewController: RMBottomSheetViewControllerDelegateProtocol {
    func didTrigger(event: BottomSheetEvents) {
        bottomSheetDelegate?.sendEvent(from: self, and: event)
    }
}
