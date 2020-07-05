//
//  SpotifyNewReleasesViewModel.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol SpotifyNewReleasesViewModelType {
    var screenTitle: String { get }
    var fetchHander: ((_ success: Bool, _ error: Error?) -> Void)? { get set }

    func fetch()
    func albumCount() -> Int
    func albumFor(_ indexPath: IndexPath) -> SpotifyAlbum
}

final class SpotifyNewReleasesViewModel: SpotifyNewReleasesViewModelType {
    public var screenTitle: String
    public var fetchHander: ((_ success: Bool, _ error: Error?) -> Void)?

    private let applicationTokenStorage: ApplicationTokenStorageType
    private let tokenProvider: TokenDataProviderType
    private let albumProvider: SpotifyAlbumsDataProviderType
    private var albumlist: [SpotifyAlbum] = []

    init(applicationTokenStorage: ApplicationTokenStorageType = ApplicationTokenStorage(),
         tokenProvider:TokenDataProviderType = TokenDataProvider(),
         albumProvider: SpotifyAlbumsDataProviderType = SpotifyAlbumsDataProvider()) {
        self.screenTitle = "sceen_title_new_releases".localized
        self.applicationTokenStorage = applicationTokenStorage
        self.tokenProvider = tokenProvider
        self.albumProvider = albumProvider
    }

    // MARK: Private methods
    private func onSuccess(albumList: SpotifyAlbumList) {
        self.albumlist = albumList.albums.items
        fetchHander?(true, nil)
    }

    private func onFailure(error: Error?) {
        fetchHander?(false, error)
    }
}

// MARK: - Request
extension SpotifyNewReleasesViewModel {
    public func fetch() {
        if let _ = applicationTokenStorage.retrieve() {
            fetchNewReleases()
        } else {
            fetchAuthorizationToken()
        }
    }

    private func fetchAuthorizationToken() {
        tokenProvider.authorizeApplication(success: { [weak self] (token) in
            self?.applicationTokenStorage.store(token)
            self?.fetch()
        }, failure: { [weak self] (error) in
            self?.onFailure(error: error)
        })
    }

    private func fetchNewReleases() {
        albumProvider.fetchNewReleasesList(success: { [weak self] (albumList) in
            self?.onSuccess(albumList: albumList)
        }, failure: { [weak self] (error) in
            self?.onFailure(error: error)
        })
    }
}

// MARK: - TableView provider
extension SpotifyNewReleasesViewModel {
    public func albumCount() -> Int {
        return albumlist.count
    }

    public func albumFor(_ indexPath: IndexPath) -> SpotifyAlbum {
        return albumlist[indexPath.item]
    }
}
