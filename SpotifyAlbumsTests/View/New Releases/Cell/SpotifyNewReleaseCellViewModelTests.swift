//
//  SpotifyNewReleaseCellViewModelTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class SpotifyNewReleaseCellViewModelTests: XCTestCase {
    var sut: SpotifyNewReleaseCellViewModel!

    override func setUp() {
        super.setUp()
        sut = SpotifyNewReleaseCellViewModel(album: Mocked.album)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_newReleaseCell_data() {
        // THEN
        XCTAssertEqual(sut.albumName, "name")
        XCTAssertEqual(sut.albumImageUrl, "image")
        XCTAssertEqual(sut.albumReleaseDate, "Release date: 15.12.1981")
        XCTAssertEqual(sut.shareUrl, "https://api.spotify.com/v1/albums/5glfCPECXSHzidU6exW8wO")
    }

    func test_newReleaseCell_shareAction() {
        // GIVEN
        var testResult: String? = nil
        let shareHandler: (_ shareUrl: String) -> Void = { url in
            testResult = url
        }
        sut.shareAction = shareHandler

        // WHEN
        sut.didTouchShareButton()

        // THEN
        XCTAssertNotNil(testResult)
        XCTAssertEqual(testResult, "https://api.spotify.com/v1/albums/5glfCPECXSHzidU6exW8wO")
    }

    private enum Mocked {
        private static let image = SpotifyAlbumImage(url: "image", height: 30, width: 30)
        private static let externalUrls = SpotifyAlbumExternalUrls(spotify: "https://api.spotify.com/v1/albums/5glfCPECXSHzidU6exW8wO")
        static let album = SpotifyAlbum(name: "name",
                                        images: [image],
                                        externalUrls: externalUrls,
                                        albumDetailsUrl: "https://api.spotify.com/v1/albums/5glfCPECXSHzidU6exW8wO",
                                        releaseDate: "1981-12-15",
                                        releaseDatePrecision: .day)
    }
}
