//
//  AppCredentials.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum AppCredentials {
    static private let clientID = "48b9be86495641e5ba729594ce521864"
    static private let clientSecret = "080ff1dde6e84addaea1943f4707fef3"
    static let encoded = "\(AppCredentials.clientID):\(AppCredentials.clientSecret)".toBase64
}
