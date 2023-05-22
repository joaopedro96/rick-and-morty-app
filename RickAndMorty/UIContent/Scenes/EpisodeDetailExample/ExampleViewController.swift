//
//  File.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

//Example view only to demonstrate navigation in the secondary tab bar item.
//No feature yet implementated here.

final class ExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red100
        title = "Example View"
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "View created only to demonstrate navigation in the secondary TabBar item with FlowManager aid."
        view.addSubview(label)
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
