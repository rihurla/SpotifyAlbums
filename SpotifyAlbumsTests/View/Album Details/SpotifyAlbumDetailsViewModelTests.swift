//
//  SpotifyAlbumDetailsViewModelTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class SpotifyAlbumDetailsViewModelTests: XCTestCase {
    var sut: SpotifyAlbumDetailsViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchAlbumDetails_withSuccess() {
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

    func test_fetchAlbumDetails_withError() {
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

    func test_fetchAlbumDetails_object() {
        // GIVEN
        var testResult: SpotifyAlbumDetails? = nil
        let handler: (_ success: Bool, _ error: Error?) -> Void = { success, _  in
            testResult = self.sut.albumDetails()
        }
        configureSut(fetchHandler: handler)

        // WHEN
        sut.fetch()

        // THEN
        XCTAssertEqual(testResult, Mocked.albumDetails)
    }

    private enum Mocked {
        private static let artist = SpotifyAlbumArtist(name: "artist")
        private static let image = SpotifyAlbumImage(url: "image", height: 30, width: 30)
        private static let externalUrls = SpotifyAlbumExternalUrls(spotify: "spotify")
        private static let albums = SpotifyAlbums(items: [album], next: nil)
        static let album = SpotifyAlbum(name: "name",
                                        images: [image],
                                        externalUrls: externalUrls,
                                        albumDetailsUrl: albumUrl,
                                        releaseDate: "1981-12-15",
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
                                                      releaseDatePrecision: .day,
                                                      genres: ["Rock"],
                                                      popularity: 1)
    }

    private func configureSut(fetchHandler: ((_ success: Bool, _ error: Error?) -> Void)?,
                              error: Error? = nil) {
        let albumProviderMocked = SpotifyAlbumsDataProviderMocked(albumList: Mocked.newReleases,
                                                                  albumDetails: Mocked.albumDetails,
                                                                  error: error)
        sut = SpotifyAlbumDetailsViewModel(albumName: "name",
                                           albumDetailsUrl: Mocked.album.albumDetailsUrl,
                                           albumProvider: albumProviderMocked)
        sut.fetchHander = fetchHandler
    }

}
