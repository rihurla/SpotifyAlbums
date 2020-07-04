//
//  ApplicationTokenStorageMocked.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import SpotifyAlbums

final class ApplicationTokenStorageMocked: ApplicationTokenStorageType {

    private var storedToken: SpotifyAuthorizationToken?

    init(storedToken: SpotifyAuthorizationToken?) {
        self.storedToken = storedToken
    }

    func store(_ token: SpotifyAuthorizationToken) {
        self.storedToken = token
    }

    func delete() {
        storedToken = nil
    }

    func retrieve() -> SpotifyAuthorizationToken? {
        return storedToken
    }
}
