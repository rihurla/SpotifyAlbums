//
//  RepositoryServiceMocked.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import SpotifyAlbums

public struct RepositoryServiceMocked: RepositoryServiceType {

    private let mockedObject: Decodable
    private let mockedError: Error?

    init(mockedObject: Decodable, mockedError: Error? = nil) {
        self.mockedObject = mockedObject
        self.mockedError = mockedError
    }

    public func makeGetRequest<T>(url: URL?, header: RepositoryParameters?, success: @escaping (T) -> Void, failure: @escaping (Error?) -> Void) where T : Decodable {
        if let error = self.mockedError {
            failure(error)
        } else {
            success(mockedObject as! T)
        }
    }

    public func makePostRequest<T>(url: URL?, header: RepositoryParameters?, body: RepositoryParameters?, success: @escaping (T) -> Void, failure: @escaping (Error?) -> Void) where T : Decodable {
        if let error = self.mockedError {
            failure(error)
        } else {
            success(mockedObject as! T)
        }
    }
}
