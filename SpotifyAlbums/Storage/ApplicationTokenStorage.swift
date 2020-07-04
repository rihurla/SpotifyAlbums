//
//  ApplicationTokenStorage.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public protocol ApplicationTokenStorageType {
    func store(_ token: SpotifyAuthorizationToken)
    func delete()
    func retrieve() -> SpotifyAuthorizationToken?
}

public final class ApplicationTokenStorage: ApplicationTokenStorageType {

    // MARK: Private properties

    private let storage: UserDefaults
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let storedTokenKey = "SpotifyApplicationToken"

    // MARK: Public methods

    init(storage: UserDefaults = UserDefaults.standard) {
        self.storage = storage
    }

    public func store(_ token: SpotifyAuthorizationToken) {
        cleanToken()
        if let encodedToken = try? encoder.encode(token) {
            storage.set(encodedToken, forKey: storedTokenKey)
        }
    }

    public func delete() {
        cleanToken()
    }

    public func retrieve() -> SpotifyAuthorizationToken? {
        if let data = storage.value(forKey: storedTokenKey) as? Data,
            let storedToken = try? decoder.decode(SpotifyAuthorizationToken.self, from: data) {
            return storedToken
        }
        return nil
    }

    // MARK: Private methods

    public func cleanToken() {
        storage.removeObject(forKey: storedTokenKey)
    }
}
