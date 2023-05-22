//
//  UIStackViewExtensions.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { itemView in
            addArrangedSubview(itemView)
        }
    }
}
