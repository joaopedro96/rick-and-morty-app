//
//  RMCharacterListViewCell.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMCharacterListViewCell: UICollectionViewCell {
    
    // MARK: - PROPERTIES
    
    static let cellIdentifier = "RMCharacterListViewCell"
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.image = nil
        nameLabel.text = nil
        originLabel.text = nil
        statusTagView.setTag(with: nil, tagColor: nil, tagText: nil)
    }
    
    // MARK: - UI
    
    private lazy var posterView: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.layer.cornerRadius = 12
        setupComponent.contentMode = .scaleToFill
        setupComponent.backgroundColor = .gray200
        setupComponent.clipsToBounds = true
        setupComponent.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return setupComponent
    }()
    
    private lazy var nameLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.font = .systemFont(ofSize: 12, weight: .bold)
        setupComponent.numberOfLines = 1
        return setupComponent
    }()
    
    private lazy var originLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 12, weight: .bold)
        setupComponent.textColor = .gray400
        setupComponent.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return setupComponent
    }()
    
    private lazy var statusTagView: RMTagView = {
        let setupComponent = RMTagView()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateCell(with characterData: RMCharacterDetailResponse) {
        nameLabel.text = characterData.name
        originLabel.text = characterData.origin.name
        statusTagView.setTag(with: characterData.status.textColor,
                             tagColor: characterData.status.tagColor,
                             tagText: characterData.status.rawValue)
        updateCellPosterView(with: characterData.image)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func updateCellPosterView(with urlString: String) {
        DispatchQueue.global().async {
            guard let loadedImage = self.getImage(from: urlString) else { return }
            DispatchQueue.main.async {
                self.posterView.image = loadedImage
            }
        }
    }
        
    private func getImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeCell()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubviews(posterView, nameLabel, originLabel, statusTagView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            nameLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            
            originLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            originLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 10),
            originLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            originLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            statusTagView.centerYAnchor.constraint(equalTo: posterView.bottomAnchor),
            statusTagView.trailingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: -10)
        ])
    }
    
    private func customizeCell() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray200.cgColor
        backgroundColor = .gray100
    }
}
