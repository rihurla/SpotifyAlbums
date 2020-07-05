//
//  SpotifyAlbumDetailsViewController.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

final class SpotifyAlbumDetailsViewController: UIViewController {

    private var viewModel: SpotifyAlbumDetailsViewModelType
    private var labelsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = DesignMetrics.Spacing.micro
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var albumCoverImageView: UIImageView = {
        let cover = UIImageView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.layer.cornerRadius = DesignMetrics.Radius.regular
        cover.clipsToBounds = true
        cover.image = DesignResources.ImageCollection.imagePlaceholderLarge
        return cover
    }()

    init(viewModel: SpotifyAlbumDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureFetchHandler()
        startAlbumDetailsFetch()
        layoutElements()
    }

    private func configureView() {
        title = viewModel.screenTitle
        view.backgroundColor = DesignResources.ColorPallete.background
        navigationController?.configureAppearance()
    }

    private func configureElements(albumDetails: SpotifyAlbumDetails?) {
        guard let album = albumDetails else { return }
        configureAlbumCover(urlString: album.images.first?.url)
        let nameLabel = makeLabel(text: album.name)
        let artistsCollection = album.artists.map { $0.name }
        let artists = artistsCollection.joined(separator: ", ")
        let artistsLabel = makeLabel(text: artists)
        let releaseDate = SpotifyAlbumReleaseDateTransformer.releaseStringDateFrom(album.releaseDate,
                                                                                   precision: album.releaseDatePrecision) ?? "album_cell_release_date_unknown".localized
        let albumReleaseDate = "album_cell_release_date_prefix".localized + " " + releaseDate
        let releaseDateLabel = makeLabel(text: albumReleaseDate)
        let genresLabel = makeLabel(text: album.genres.joined(separator: ", "))
        let popularity = "object_details_popularity_prefix".localized + " " + String(album.popularity) + " " + "object_details_popularity_suffix".localized
        let popularityLabel = makeLabel(text: popularity)
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(artistsLabel)
        labelsStackView.addArrangedSubview(releaseDateLabel)
        labelsStackView.addArrangedSubview(popularityLabel)
        labelsStackView.addArrangedSubview(genresLabel)
    }

    private func layoutElements() {
        view.addSubview(albumCoverImageView)
        view.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            albumCoverImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DesignMetrics.Spacing.large),
            albumCoverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumCoverImageView.heightAnchor.constraint(equalToConstant: DesignMetrics.Sizing.coverMedium.height),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: DesignMetrics.Sizing.coverMedium.width),

            labelsStackView.topAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: DesignMetrics.Spacing.xlarge),
            labelsStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelsStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelsStackView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0)
        ])
    }

    private func configureFetchHandler() {
        viewModel.fetchHander = { [weak self] (success, error) in
            DispatchQueue.main.async {
                if success {
                    self?.configureElements(albumDetails: self?.viewModel.albumDetails())
                } else {
                    self?.displayError(error)
                }
            }
        }
    }

    private func startAlbumDetailsFetch() {
        viewModel.fetch()
    }

    private func displayError(_ error: Error?) {
        var errorMessage: String
        if let error = error {
            errorMessage = error.localizedDescription
        } else {
            errorMessage = "generic_error_message".localized
        }
        let alert = UIAlertController(title: "generic_error_title".localized, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "generic_error_button_title".localized, style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
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

    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = DesignResources.FontColletion.largeBold
        label.textColor = DesignResources.ColorPallete.text
        label.text = text
        return label
    }
}
