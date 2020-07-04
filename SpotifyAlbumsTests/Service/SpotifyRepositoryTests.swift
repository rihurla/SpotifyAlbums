//
//  SpotifyRepositoryTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class SpotifyRepositoryTests: XCTestCase {

    var sut: SpotifyRepository!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchAuthorizationToken_withSuccess() {
        // GIVEN
        configureSut(mockedObject: Mocked.token)
        var testResult: SpotifyAuthorizationToken?

        // WHEN
        sut.authorizeApplication(header: nil, body: nil, success: { (token) in
            testResult = token
        }, failure: { (error) in
            XCTFail("Should not call failure while testing success")
        })

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchAuthorizationToken_responseObject() {
        // GIVEN
        let expectedToken = Mocked.token
        configureSut(mockedObject: Mocked.token)
        var testResult: SpotifyAuthorizationToken?

        // WHEN
        sut.authorizeApplication(header: nil, body: nil, success: { (token) in
            testResult = token
        }, failure: { (error) in
            XCTFail("Should not call failure while testing success")
        })

        // THEN
        XCTAssertEqual(testResult, expectedToken)
    }

    func test_fetchAuthorizationToken_withError() {
        // GIVEN
        configureSut(mockedObject: Mocked.token, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.authorizeApplication(header: nil, body: nil, success: { (token) in
            XCTFail("Should not call success while testing error")
        }, failure: { (error) in
            testResult = error
        })

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchAuthorizationToken_errorDescription() {
        // GIVEN
        let expectedErrorDescription = "Check your internet connection and try again."
        configureSut(mockedObject: Mocked.token, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.authorizeApplication(header: nil, body: nil, success: { (token) in
            XCTFail("Should not call success while testing error")
        }, failure: { (error) in
            testResult = error
        })

        // THEN
        XCTAssertEqual(testResult?.localizedDescription, expectedErrorDescription)
    }

    func test_fetchNewReleases_withSuccess() {
        // GIVEN
        configureSut(mockedObject: Mocked.newReleases)
        var testResult: SpotifyAlbumList?

        // WHEN
        sut.fetchNewReleasesList(parameters: nil, success: { (albumList) in
            testResult = albumList
        }, failure: { (error) in
            XCTFail("Should not call failure while testing success")
        })

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchNewReleases_responseObject() {
        // GIVEN
        let expectedList = Mocked.newReleases
        configureSut(mockedObject: Mocked.newReleases)
        var testResult: SpotifyAlbumList?

        // WHEN
        sut.fetchNewReleasesList(parameters: nil, success: { (albumList) in
            testResult = albumList
        }, failure: { (error) in
            XCTFail("Should not call failure while testing success")
        })

        // THEN
        XCTAssertEqual(testResult, expectedList)
    }

    func test_fetchNewReleases_withError() {
        // GIVEN
        configureSut(mockedObject: Mocked.newReleases, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.fetchNewReleasesList(parameters: nil, success: { (albumList) in
            XCTFail("Should not call success while testing error")
        }, failure: { (error) in
            testResult = error
        })

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchNewReleases_errorDescription() {
        // GIVEN
        let expectedErrorDescription = "Check your internet connection and try again."
        configureSut(mockedObject: Mocked.newReleases, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.fetchNewReleasesList(parameters: nil, success: { (albumList) in
            XCTFail("Should not call success while testing error")
        }, failure: { (error) in
            testResult = error
        })

        // THEN
        XCTAssertEqual(testResult?.localizedDescription, expectedErrorDescription)
    }

    // MARK: Private
    private enum Mocked {
        private static let artist = SpotifyAlbumArtist(name: "artist")
        private static let image = SpotifyAlbumImage(url: "image", height: 30, width: 30)
        private static let externalUrls = SpotifyAlbumExternalUrls(spotify: "spotify")
        private static let album = SpotifyAlbum(name: "name", artists: [artist], images: [image], externalUrls: externalUrls)
        private static let albums = SpotifyAlbums(items: [album], next: nil)

        static let error = RepositoryError.requestFailure
        static let token = SpotifyAuthorizationToken(accessToken: "token",
                                                     tokenType: "type",
                                                     expiresIn: 1234)
        static let newReleases = SpotifyAlbumList(albums: albums)
    }

    private func configureSut(mockedObject: Decodable, error: Error? = nil) {
        let repositoryService = RepositoryServiceMocked(mockedObject: mockedObject, mockedError: error)
        let tokenStorage = ApplicationTokenStorageMocked(storedToken: Mocked.token)
        sut = SpotifyRepository(service: repositoryService, applicationTokenStorage: tokenStorage)
    }

}
