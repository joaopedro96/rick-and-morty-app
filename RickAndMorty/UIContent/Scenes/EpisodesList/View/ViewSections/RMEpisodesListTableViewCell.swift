//
//  RMEpisodesListTableViewCell.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import UIKit

final class RMEpisodesListTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let identifier = "RMEpisodesListTableViewCell"
    
    // MARK: - INITIALIZER
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        episodeLabel.text = nil
        airDateLabel.text = nil
    }
    
    // MARK: - UI
    
    private lazy var posterView: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .clear
        setupComponent.contentMode = .scaleToFill
        setupComponent.clipsToBounds = true
        setupComponent.image = .init(systemName: "chevron.forward")?.withTintColor(.gray400).withRenderingMode(.alwaysOriginal)
        setupComponent.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return setupComponent
    }()
    
    private lazy var stackView: UIStackView = {
        let setupComponent = UIStackView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.axis = .vertical
        setupComponent.distribution = .fill
        setupComponent.spacing = 4
        return setupComponent
    }()
    
    private lazy var titleLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 14, weight: .bold)
        setupComponent.textColor = .gray500
        return setupComponent
    }()
    
    private lazy var episodeLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 14, weight: .regular)
        setupComponent.textColor = .gray400
        return setupComponent
    }()
    
    private lazy var airDateLabel: UILabel = {
        let setupComponent = UILabel(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.numberOfLines = 1
        setupComponent.font = .systemFont(ofSize: 14, weight: .regular)
        setupComponent.textColor = .gray400
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    public func updateCell(with data: RMEpisodeDetailResponse) {
        titleLabel.text = data.name
        episodeLabel.text = data.episode
        airDateLabel.text = data.airDate
    }

    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
        customizeView()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubviews(posterView, stackView)
        stackView.addArrangedSubviews(titleLabel, episodeLabel, airDateLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: -12),
            stackView.centerYAnchor.constraint(equalTo: posterView.centerYAnchor),
            
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            posterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func customizeView() {
        backgroundColor = .clear
        contentView.backgroundColor = .gray100
        contentView.layer.cornerRadius = 8
    }
}
