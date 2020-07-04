//
//  RepositoryError.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum RepositoryError: Error {
    case urlError
    case requestFailure
}

extension RepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError, .requestFailure:
            return "repository_default_generic_error".localized
        }
    }
}
