//
//  SpotifyNewReleasesViewModelTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class SpotifyNewReleasesViewModelTests: XCTestCase {
    var sut: SpotifyNewReleasesViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchNewReleasesList_successfully() {
        // GIVEN
        var testResult: Bool = false
        var testError: Error? = nil
        let handler: (_ success: Bool, _ error: Error?) -> Void = { success, error  in
            testResult = success
            testError = error
        }
        configureSut(fetchHandler: handler)

        // WHEN
        sut.fetch()

        // THEN
        XCTAssertTrue(testResult)
        XCTAssertNil(testError)
    }

    func test_fetchNewReleasesList_withFailure() {
        // GIVEN
        var testResult: Bool = true
        var testError: Error? = nil
        let handler: (_ success: Bool, _ error: Error?) -> Void = { success, error  in
            testResult = success
            testError = error
        }
        configureSut(fetchHandler: handler, error: Mocked.error)

        // WHEN
        sut.fetch()

        // THEN
        XCTAssertFalse(testResult)
        XCTAssertNotNil(testError)
        XCTAssertEqual(testError?.localizedDescription, "Check your internet connection and try again.")
    }

    func test_newReleases_count() {
        // GIVEN
        var testResult: Int = 0
        let handler: (_ success: Bool, _ error: Error?) -> Void = { success, _  in
            testResult = self.sut.albumCount()
        }
        configureSut(fetchHandler: handler)

        // WHEN
        sut.fetch()
        XCTAssertEqual(testResult, 1)
    }

    func test_newReleases_albumForIndexPath() {
        // GIVEN
        var testResult: SpotifyAlbum? = nil
        let handler: (_ success: Bool, _ error: Error?) -> Void = { success, _  in
            testResult = self.sut.albumFor(IndexPath(item: 0, section: 0))
        }
        configureSut(fetchHandler: handler)

        // WHEN
        sut.fetch()
        XCTAssertEqual(testResult, Mocked.album)
    }

    private enum Mocked {
        private static let artist = SpotifyAlbumArtist(name: "artist")
        private static let image = SpotifyAlbumImage(url: "image", height: 30, width: 30)
        private static let externalUrls = SpotifyAlbumExternalUrls(spotify: "spotify")
        private static let albums = SpotifyAlbums(items: [album], next: nil)
        static let album = SpotifyAlbum(name: "name",
                                        images: [image],
                                        externalUrls: externalUrls,
                                        albumDetailsUrl: "",
                                        releaseDate: "",
                                        releaseDatePrecision: .day)
        static let albumUrl = "https://api.spotify.com/v1/albums/5glfCPECXSHzidU6exW8wO"
        static let error = RepositoryError.requestFailure
        static let token = SpotifyAuthorizationToken(accessToken: "token",
                                                     tokenType: "type",
                                                     expiresIn: 1234)
        static let newReleases = SpotifyAlbumList(albums: albums)
        static let albumDetails = SpotifyAlbumDetails(type: .album,
                                                      name: "name",
                                                      artists: [artist],
                                                      images: [image],
                                                      externalUrls: externalUrls,
                                                      albumDetailsUrl: "",
                                                      releaseDate: "",
                                                      releaseDatePrecision: .day)
    }

    private func configureSut(fetchHandler: ((_ success: Bool, _ error: Error?) -> Void)?, error: Error? = nil) {
        let applicationTokenStorageMocked = ApplicationTokenStorageMocked(storedToken: Mocked.token)
        let tokenProviderMocked = TokenDataProviderMocked(token: Mocked.token, error: error)
        let albumProviderMocked = SpotifyAlbumsDataProviderMocked(albumList: Mocked.newReleases,
                                                                  albumDetails: Mocked.albumDetails,
                                                                  error: error)
        sut = SpotifyNewReleasesViewModel(applicationTokenStorage: applicationTokenStorageMocked,
                                          tokenProvider: tokenProviderMocked,
                                          albumProvider: albumProviderMocked)
        sut.fetchHander = fetchHandler
    }

}
