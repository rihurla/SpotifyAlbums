//
//  SpotifyAlbumReleaseDateTransformer.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

struct SpotifyAlbumReleaseDateTransformer {
    private static var parseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    private static var printDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()

    private static func releaseDateFrom(_ releaseDate: String, precision: SpotifyAlbumReleaseDatePrecision) -> Date? {
        switch precision {
        case .year:
            parseDateFormatter.dateFormat = "yyyy"
        case .month:
            parseDateFormatter.dateFormat = "yyyy.MM"
        case .day:
            parseDateFormatter.dateFormat = "yyyy.MM.dd"
        }
        guard let date = parseDateFormatter.date(from: releaseDate) else { return nil }
        return date
    }

    static func releaseStringDateFrom(_ releaseDate: String, precision: SpotifyAlbumReleaseDatePrecision) -> String? {
        switch precision {
        case .year:
            printDateFormatter.dateFormat = "yyyy"
        case .month:
            printDateFormatter.dateFormat = "MM.yyyy"
        case .day:
            printDateFormatter.dateFormat = "dd.MM.yyyy"
        }
        guard let date = releaseDateFrom(releaseDate, precision: precision) else { return nil }
        return printDateFormatter.string(from: date)
    }
}
