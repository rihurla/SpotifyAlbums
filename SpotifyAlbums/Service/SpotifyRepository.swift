//
//  SpotifyRepository.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public protocol SpotifyRepositoryType {
    func authorizeApplication(header: RepositoryParameters?,
                              body: RepositoryParameters?,
                              success: @escaping (SpotifyAuthorizationToken) -> Void,
                              failure: @escaping (Error?) -> Void)
}

public struct SpotifyRepository: SpotifyRepositoryType {
    private let service: RepositoryServiceType

    init(service: RepositoryServiceType = RepositoryService()) {
        self.service = service
    }

    public func authorizeApplication(header: RepositoryParameters?,
                                     body: RepositoryParameters?,
                                     success: @escaping (SpotifyAuthorizationToken) -> Void,
                                     failure: @escaping (Error?) -> Void) {
        var components = URLComponents()
        components.scheme = ServiceUrls.scheme
        components.host = ServiceUrls.accountUrl
        components.path = ServiceUrls.Endpoints.token
        service.makePostRequest(url: components.url,
                                header: header,
                                body: body, success: { (token: SpotifyAuthorizationToken) in
            success(token)
        }, failure: { (error) in
            failure(error)
        })
    }
}
