//
//  SpotifyAlbum.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum SpotifyAlbumReleaseDatePrecision: String, Decodable {
    case year
    case month
    case day
}

public struct SpotifyAlbum: Decodable, Equatable {
    let name: String
    let images: [SpotifyAlbumImage]
    let externalUrls: SpotifyAlbumExternalUrls
    let albumDetailsUrl: String
    let releaseDate: String
    let releaseDatePrecision: SpotifyAlbumReleaseDatePrecision

    enum CodingKeys: String, CodingKey {
        case name
        case images
        case externalUrls = "external_urls"
        case albumDetailsUrl = "href"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
    }
}
