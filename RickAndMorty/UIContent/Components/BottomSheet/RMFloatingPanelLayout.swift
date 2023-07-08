//
//  RMFloatingPanelLayout.swift
//  RickAndMorty
//
//  Created by João Pedro Mata on 18/06/23.
//

import Foundation
import FloatingPanel

class KBFloatingPanelLayout: FloatingPanelLayout {
    
    var contentHeight: CGFloat
    
    init(contentHeight: CGFloat) {
        self.contentHeight = contentHeight
    }
    
    var initialPosition: FloatingPanel.FloatingPanelPosition = .half
    
    var positionReference: FloatingPanelLayoutReference = .fromSuperview
    
    var supportedPositions: Set<FloatingPanelPosition> {
        return Set([.half])
    }
    
    func insetFor(position: FloatingPanel.FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .half:
                guard let window = UIApplication.shared.windows.first else { return nil }
                let frameHeight = window.safeAreaLayoutGuide.layoutFrame.size.height - 18
                return min(contentHeight, frameHeight)
            default: return nil
        }
    }
    
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
            default: return 0.3
        }
    }
}
