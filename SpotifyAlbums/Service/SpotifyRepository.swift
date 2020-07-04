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
    func fetchNewReleasesList(parameters: RepositoryParameters?,
                              success: @escaping (SpotifyAlbumList) -> Void,
                              failure: @escaping (Error?) -> Void)
}

public struct SpotifyRepository: SpotifyRepositoryType {
    private let service: RepositoryServiceType
    private let tokenStorage: ApplicationTokenStorageType

    init(service: RepositoryServiceType = RepositoryService(),
         applicationTokenStorage: ApplicationTokenStorageType = ApplicationTokenStorage()) {
        self.service = service
        self.tokenStorage = applicationTokenStorage
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

    public func fetchNewReleasesList(parameters: RepositoryParameters?,
                                     success: @escaping (SpotifyAlbumList) -> Void,
                                     failure: @escaping (Error?) -> Void) {
        guard let token = tokenStorage.retrieve() else {
            failure(RepositoryError.sessionExpired)
            return
        }
        let headerParameters: RepositoryParameters = [
            "Authorization": "\(token.tokenType) \(token.accessToken)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var components = URLComponents()
        components.scheme = ServiceUrls.scheme
        components.host = ServiceUrls.apiBaseUrl
        components.path = ServiceUrls.apiVersion + ServiceUrls.Endpoints.newReleases
        if let queryParameters = parameters { components.setQueryItems(with: queryParameters) }
        service.makeGetRequest(url: components.url, header: headerParameters, success: { (newReleases: SpotifyAlbumList) in
            success(newReleases)
        }, failure: { (error) in
            failure(error)
        })
    }
}
