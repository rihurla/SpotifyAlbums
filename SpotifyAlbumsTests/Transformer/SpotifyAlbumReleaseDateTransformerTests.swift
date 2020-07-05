//
//  SpotifyAlbumReleaseDateTransformerTests.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import SpotifyAlbums

class SpotifyAlbumReleaseDateTransformerTests: XCTestCase {
    func test_releaseStringDateFrom_dayPrecisionType() {
        // GIVEN
        let precision = SpotifyAlbumReleaseDatePrecision.day
        let date = "1981-12-15"

        // WHEN
        let testDate = SpotifyAlbumReleaseDateTransformer.releaseStringDateFrom(date, precision: precision)

        // THEN
        XCTAssertEqual(testDate, "15.12.1981")
    }

    func test_releaseStringDateFrom_monthPrecisionType() {
        // GIVEN
        let precision = SpotifyAlbumReleaseDatePrecision.month
        let date = "1981-12"

        // WHEN
        let testDate = SpotifyAlbumReleaseDateTransformer.releaseStringDateFrom(date, precision: precision)

        // THEN
        XCTAssertEqual(testDate, "12.1981")
    }

    func test_releaseStringDateFrom_yearPrecisionType() {
        // GIVEN
        let precision = SpotifyAlbumReleaseDatePrecision.year
        let date = "1981"

        // WHEN
        let testDate = SpotifyAlbumReleaseDateTransformer.releaseStringDateFrom(date, precision: precision)

        // THEN
        XCTAssertEqual(testDate, "1981")
    }
}
