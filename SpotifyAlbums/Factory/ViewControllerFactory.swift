//
//  ViewControllerFactory.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

public enum ViewControllerFactoryType {
    case newReleasesViewController
    case albumDetailsViewController(albumName: String, albumUrl: String)
}

public enum ViewControllerFactory {
    static func makeViewController(_ viewControllerType: ViewControllerFactoryType) -> UIViewController {
        switch viewControllerType {
        case .newReleasesViewController:
            let viewModel = SpotifyNewReleasesViewModel()
            return SpotifyNewReleasesViewController(viewModel: viewModel)
        case .albumDetailsViewController(let albumName, let albumUrl):
            let viewModel = SpotifyAlbumDetailsViewModel(albumName: albumName, albumDetailsUrl: albumUrl)
            return SpotifyAlbumDetailsViewController(viewModel: viewModel)
        }
    }
}
