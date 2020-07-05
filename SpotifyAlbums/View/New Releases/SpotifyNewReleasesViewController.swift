//
//  SpotifyNewReleasesViewController.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

final class SpotifyNewReleasesViewController: UIViewController {

    // MARK: Private properties
    private var viewModel: SpotifyNewReleasesViewModelType
    private let tableView: UITableView

    // MARK: Lifecyle
    public init(viewModel: SpotifyNewReleasesViewModelType) {
        self.viewModel = viewModel
        tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureFetchHandler()
        startNewReleasesFetch()
    }

    private func configureView() {
        title = viewModel.screenTitle
        view.backgroundColor = DesignResources.ColorPallete.background
        view.addSubview(tableView)
        navigationController?.configureAppearance()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SpotifyNewReleaseCell.self, forCellReuseIdentifier: SpotifyNewReleaseCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func configureFetchHandler() {
        viewModel.fetchHander = { [weak self] (success, error) in
            DispatchQueue.main.async {
                if success {
                    self?.tableView.reloadData()
                } else {
                    self?.displayError(error)
                }
            }
        }
    }

    private func startNewReleasesFetch() {
        viewModel.fetch()
    }

    private func shareAlbum(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let items = [url]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
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
}

// MARK: - UITableViewDataSource

extension SpotifyNewReleasesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumCount()
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = SpotifyNewReleaseCellViewModel(album: viewModel.albumFor(indexPath))
        cellViewModel.shareAction = { [weak self] shareUrl in
            self?.shareAlbum(shareUrl)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SpotifyNewReleaseCell.identifier, for: indexPath) as! SpotifyNewReleaseCell
        cell.configure(viewModel: cellViewModel)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
}

extension SpotifyNewReleasesViewController: UITableViewDelegate {
}
