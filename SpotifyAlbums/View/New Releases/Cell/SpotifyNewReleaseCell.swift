//
//  SpotifyNewReleaseCell.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

final class SpotifyNewReleaseCell: UITableViewCell {
    public static let identifier = "SpotifyNewReleaseCell"
    private var viewModel: SpotifyNewReleaseCellViewModelType?
    private lazy var albumCoverImageView: UIImageView = {
        let cover = UIImageView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.layer.cornerRadius = DesignMetrics.Radius.regular
        cover.clipsToBounds = true
        cover.image = DesignResources.ImageCollection.imagePlaceholderSmall
        return cover
    }()

    private lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = DesignResources.FontColletion.largeBold
        label.textColor = DesignResources.ColorPallete.text
        return label
    }()

    private lazy var albumReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = DesignResources.FontColletion.small
        label.textColor = DesignResources.ColorPallete.text
        return label
    }()

    private var labelsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = DesignMetrics.Spacing.micro
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(DesignResources.ImageCollection.shareIcon, for: .normal)
        button.addTarget(self, action: #selector(didTouchShareButton), for: .touchUpInside)
        return button
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        albumCoverImageView.image = DesignResources.ImageCollection.imagePlaceholderSmall
        albumTitleLabel.text = nil
        albumReleaseDateLabel.text = nil
        viewModel = nil
    }

    func configure(viewModel: SpotifyNewReleaseCellViewModelType) {
        self.viewModel = viewModel
        configureElements()
        layoutElements()
    }

    private func configureElements() {
        guard let viewModel = self.viewModel else { return }
        translatesAutoresizingMaskIntoConstraints = false
        albumTitleLabel.text = viewModel.albumName
        albumReleaseDateLabel.text = viewModel.albumReleaseDate
        configureAlbumCover(urlString: viewModel.albumImageUrl)
        contentView.addSubview(albumCoverImageView)
        labelsStackView.addArrangedSubview(albumTitleLabel)
        labelsStackView.addArrangedSubview(albumReleaseDateLabel)
        contentView.addSubview(labelsStackView)
        contentView.addSubview(shareButton)
    }

    private func layoutElements() {
        NSLayoutConstraint.activate([
            albumCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DesignMetrics.Spacing.large),
            albumCoverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: DesignMetrics.Spacing.large),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: DesignMetrics.Sizing.coverSmall.width),
            albumCoverImageView.heightAnchor.constraint(equalToConstant: DesignMetrics.Sizing.coverSmall.height),

            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DesignMetrics.Spacing.large),
            labelsStackView.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: DesignMetrics.Spacing.large),
            labelsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                   constant: -(DesignMetrics.Spacing.large + DesignMetrics.Sizing.smallButton.width)),

            shareButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DesignMetrics.Spacing.medium),
            shareButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -DesignMetrics.Spacing.small),
            shareButton.widthAnchor.constraint(equalToConstant: DesignMetrics.Sizing.smallButton.width),
            shareButton.heightAnchor.constraint(equalToConstant: DesignMetrics.Sizing.smallButton.height)
        ])

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: DesignMetrics.Spacing.large)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
    }

    private func configureAlbumCover(urlString: String?) {
        guard let imageUrlString = urlString, let url = URL(string: imageUrlString) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.albumCoverImageView.image = UIImage(data: data)
                }
            } catch {
                return
            }
        }
    }

    @objc
    private func didTouchShareButton() {
        self.viewModel?.didTouchShareButton()
    }
}
