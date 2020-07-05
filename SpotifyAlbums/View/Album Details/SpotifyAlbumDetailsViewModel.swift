//
//  SpotifyAlbumDetailsViewModel.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol SpotifyAlbumDetailsViewModelType {
    var screenTitle: String { get }
    var fetchHander: ((_ success: Bool, _ error: Error?) -> Void)? { get set }
    func fetch()
    func albumDetails() -> SpotifyAlbumDetails?
}

final class SpotifyAlbumDetailsViewModel: SpotifyAlbumDetailsViewModelType {
    public var screenTitle: String
    private let albumDetailsUrl: String
    private let albumProvider: SpotifyAlbumsDataProviderType
    private var album: SpotifyAlbumDetails?
    public var fetchHander: ((_ success: Bool, _ error: Error?) -> Void)?

    init(albumName: String,
         albumDetailsUrl: String,
         albumProvider: SpotifyAlbumsDataProviderType = SpotifyAlbumsDataProvider()) {
        self.screenTitle = albumName
        self.albumDetailsUrl = albumDetailsUrl
        self.albumProvider = albumProvider
    }

    public func fetch() {
        albumProvider.fetchAlbumDetails(albumUrl: albumDetailsUrl, success: { [weak self] (albumDetails) in
            self?.onSuccess(albumDetails: albumDetails)
        }, failure: { [weak self] (error) in
            self?.onFailure(error: error)
        })
    }

    public func albumDetails() -> SpotifyAlbumDetails? {
        return album
    }

    // MARK: Private methods
    private func onSuccess(albumDetails: SpotifyAlbumDetails) {
        album = albumDetails
        fetchHander?(true, nil)
    }

    private func onFailure(error: Error?) {
        fetchHander?(false, error)
    }
}
