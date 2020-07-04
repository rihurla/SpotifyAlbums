//
//  ApplicationTokenStorageTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class ApplicationTokenStorageTests: XCTestCase {

    var sut: ApplicationTokenStorage!

    override func setUp() {
        super.setUp()
        sut = ApplicationTokenStorage(storage: UserDefaultsMocked())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_storeToken() {
        // WHEN
        sut.store(Mocked.token)

        // THEN
        XCTAssertNotNil(sut.retrieve())
    }

    func test_deleteToken() {
        // GIVEN
        sut.store(Mocked.token)

        // WHEN
        sut.delete()

        // THEN
        XCTAssertNil(sut.retrieve())
    }

    func test_retrieveToken() {
        // GIVEN
        sut.store(Mocked.token)

        // THEN
        XCTAssertNotNil(sut.retrieve())
        XCTAssertEqual(sut.retrieve(), Mocked.token)
    }

    func test_retrieveToken_withoutStoredToken() {
        // THEN
        XCTAssertNil(sut.retrieve())
    }

    private enum Mocked {
        static let token = SpotifyAuthorizationToken(accessToken: "token",
                                                     tokenType: "type",
                                                     expiresIn: 1234)
    }
}
