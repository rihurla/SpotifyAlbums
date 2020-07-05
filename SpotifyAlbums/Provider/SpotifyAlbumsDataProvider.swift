//
//  SpotifyAlbumsDataProvider.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol SpotifyAlbumsDataProviderType {
    func fetchNewReleasesList(success: @escaping (SpotifyAlbumList) -> Void,
                              failure: @escaping (Error?) -> Void)
    func fetchAlbumDetails(albumUrl: String,
                           success: @escaping (SpotifyAlbumDetails) -> Void,
                           failure: @escaping (Error?) -> Void)
}

public struct SpotifyAlbumsDataProvider: SpotifyAlbumsDataProviderType {

    // MARK: Private properties
    private let repository: SpotifyRepositoryType
    private let queryparameters: RepositoryParameters = [
        "country": "GB",
        "limit": "1"
    ]

    // MARK: Public methods
    init(repository: SpotifyRepositoryType = SpotifyRepository()) {
        self.repository = repository
    }

    func fetchNewReleasesList(success: @escaping (SpotifyAlbumList) -> Void,
                              failure: @escaping (Error?) -> Void) {
        self.repository.fetchNewReleasesList(parameters: queryparameters,
                                             success: success,
                                             failure: failure)
    }

    func fetchAlbumDetails(albumUrl: String,
                           success: @escaping (SpotifyAlbumDetails) -> Void,
                           failure: @escaping (Error?) -> Void) {
        self.repository.fetchAlbumDetails(albumUrl: albumUrl,
                                          success: success,
                                          failure: failure)
    }
}
