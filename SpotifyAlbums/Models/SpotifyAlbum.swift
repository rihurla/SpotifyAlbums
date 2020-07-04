//
//  SpotifyAlbum.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct SpotifyAlbum: Decodable, Equatable {
    let name: String
    let artists: [SpotifyAlbumArtist]
    let images: [SpotifyAlbumImage]
    let externalUrls: SpotifyAlbumExternalUrls

    enum CodingKeys: String, CodingKey {
        case name
        case artists
        case images
        case externalUrls = "external_urls"
    }
}
