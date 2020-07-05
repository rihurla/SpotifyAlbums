//
//  SpotifyAlbumsDataProviderMocked.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import SpotifyAlbums

public struct SpotifyAlbumsDataProviderMocked: SpotifyAlbumsDataProviderType {

    private let albumList: SpotifyAlbumList
    private let albumDetails: SpotifyAlbumDetails
    private let error: Error?

    init(albumList: SpotifyAlbumList, albumDetails: SpotifyAlbumDetails, error: Error?) {
        self.albumList = albumList
        self.albumDetails = albumDetails
        self.error = error
    }

    public func fetchNewReleasesList(success: @escaping (SpotifyAlbumList) -> Void, failure: @escaping (Error?) -> Void) {
        if let fetchError = self.error {
            failure(fetchError)
        } else {
            success(albumList)
        }
    }

    public func fetchAlbumDetails(albumUrl: String, success: @escaping (SpotifyAlbumDetails) -> Void, failure: @escaping (Error?) -> Void) {
        if let fetchError = self.error {
            failure(fetchError)
        } else {
            success(albumDetails)
        }
    }
}
