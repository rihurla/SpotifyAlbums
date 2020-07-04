//
//  SpotifyAlbumImage.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct SpotifyAlbumImage: Decodable, Equatable {
    let url: String
    let height: Double
    let width: Double
}
