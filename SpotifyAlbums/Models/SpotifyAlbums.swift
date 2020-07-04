//
//  SpotifyAlbums.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct SpotifyAlbums: Decodable, Equatable {
    let items: [SpotifyAlbum]
    let next: String?
}
