//
//  TokenDataProvider.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol TokenDataProviderType {
    func authorizeApplication(success: @escaping (SpotifyAuthorizationToken) -> Void,
                              failure: @escaping (Error?) -> Void)
}

public struct TokenDataProvider: TokenDataProviderType {

    // MARK: Private properties
    private let repository: SpotifyRepositoryType
    private let headerParameters: RepositoryParameters = [
        "Authorization": "Basic \(AppCredentials.encoded)",
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    private let bodyParameters: RepositoryParameters = [
        "grant_type": "client_credentials"
    ]

    // MARK: Public methods
    init(repository: SpotifyRepositoryType = SpotifyRepository()) {
        self.repository = repository
    }

    public func authorizeApplication(success: @escaping (SpotifyAuthorizationToken) -> Void,
                                     failure: @escaping (Error?) -> Void) {
        repository.authorizeApplication(header: headerParameters,
                                        body: bodyParameters,
                                        success: success,
                                        failure: failure)
    }
}
