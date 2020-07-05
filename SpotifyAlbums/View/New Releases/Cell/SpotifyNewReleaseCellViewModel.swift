//
//  SpotifyNewReleaseCellViewModel.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol SpotifyNewReleaseCellViewModelType {
    var albumName: String { get }
    var albumImageUrl: String? { get }
    var albumReleaseDate: String? { get }
    var shareUrl: String { get }

    var shareAction: ((_ shareUrl: String) -> Void)? { get set }
    func didTouchShareButton()
}

final class SpotifyNewReleaseCellViewModel: SpotifyNewReleaseCellViewModelType {
    var shareAction: ((String) -> Void)?
    private let album: SpotifyAlbum
    let albumName: String
    let albumImageUrl: String?
    let albumReleaseDate: String?
    let shareUrl: String

    init(album: SpotifyAlbum) {
        self.album = album
        self.albumName = album.name
        self.albumImageUrl = album.images.last?.url
        let releaseDate = SpotifyAlbumReleaseDateTransformer.releaseStringDateFrom(album.releaseDate,
                                                                                   precision: album.releaseDatePrecision) ?? "album_cell_release_date_unknown".localized

        self.albumReleaseDate = "album_cell_release_date_prefix".localized + " " + releaseDate
        self.shareUrl = album.externalUrls.spotify
    }

    public func didTouchShareButton() {
        shareAction?(self.shareUrl)
    }
}
