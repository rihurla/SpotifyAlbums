//
//  SpotifyAlbumDetails.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum SpotifyAlbumType: String, Decodable {
    case album
    case single
    case compilation
}

public struct SpotifyAlbumDetails: Decodable, Equatable {
    let type: SpotifyAlbumType
    let name: String
    let artists: [SpotifyAlbumArtist]
    let images: [SpotifyAlbumImage]
    let externalUrls: SpotifyAlbumExternalUrls
    let albumDetailsUrl: String
    let releaseDate: String
    let releaseDatePrecision: SpotifyAlbumReleaseDatePrecision

    enum CodingKeys: String, CodingKey {
        case type = "album_type"
        case name
        case artists
        case images
        case externalUrls = "external_urls"
        case albumDetailsUrl = "href"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
    }
}
