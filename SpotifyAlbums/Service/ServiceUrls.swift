//
//  ServiceUrls.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum ServiceUrls {
    static let scheme = "https"
    static let apiVersion = "/v1"
    static let apiBaseUrl = "api.spotify.com"
    static let accountUrl = "accounts.spotify.com"

    enum Endpoints {
        static let token = "/api/token"
        static let newReleases = "/browse/new-releases"
    }
}
