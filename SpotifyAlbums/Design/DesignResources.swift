//
//  DesignResources.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

public enum DesignResources {
    enum ColorPallete {
        static let background = UIColor.white
        static let text = UIColor.black
    }

    enum FontColletion {
        private enum FontSize {
            static let small = CGFloat(12)
            static let regular = CGFloat(14)
            static let large = CGFloat(16)
        }
        static let small = UIFont.systemFont(ofSize: FontSize.regular)
        static let regular = UIFont.systemFont(ofSize: FontSize.small)
        static let large = UIFont.systemFont(ofSize: FontSize.large)
        static let smallBold = UIFont.boldSystemFont(ofSize: FontSize.regular)
        static let regularBold = UIFont.boldSystemFont(ofSize: FontSize.small)
        static let largeBold = UIFont.boldSystemFont(ofSize: FontSize.large)

    }

    enum ImageCollection {
        static let shareIcon = UIImage(named: "share-icon")?.withRenderingMode(.alwaysTemplate)
        static let imagePlaceholderSmall = UIImage(named: "image-placeholder-small")
        static let imagePlaceholderLarge = UIImage(named: "image-placeholder-large")
    }
}
