//
//  DesignMetrics.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import CoreGraphics

public enum DesignMetrics {
    enum Sizing {
        static let coverSmall = CGSize(width: 64, height: 64)
        static let coverMedium = CGSize(width: 300, height: 300)
        static let coverLarge = CGSize(width: 640, height: 640)
        static let smallButton = CGSize(width: 40, height: 40)
    }

    enum Spacing {
        private static let unit = CGFloat(5)
        static let micro = unit
        static let small = unit * 2
        static let medium = unit * 3
        static let large = unit * 4
        static let xlarge = unit * 5
    }

    enum Radius {
        static let regular = CGFloat(4)
    }

    enum CellRowHeight {
        static let regular = CGFloat(120)
    }
}
