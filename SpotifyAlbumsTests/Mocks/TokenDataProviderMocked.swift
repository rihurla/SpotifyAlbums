//
//  TokenDataProviderMocked.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import SpotifyAlbums

public struct TokenDataProviderMocked: TokenDataProviderType {
    private let token: SpotifyAuthorizationToken
    private let error: Error?
    init(token: SpotifyAuthorizationToken, error: Error?) {
        self.token = token
        self.error = error
    }
    public func authorizeApplication(success: @escaping (SpotifyAuthorizationToken) -> Void, failure: @escaping (Error?) -> Void) {
        if let fetchError = self.error {
            failure(fetchError)
        } else {
            success(token)
        }
    }
}
