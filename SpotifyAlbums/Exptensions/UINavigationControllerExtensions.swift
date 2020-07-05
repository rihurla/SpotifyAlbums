//
//  UINavigationControllerExtensions.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 05/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import UIKit

extension UINavigationController {
    func configureAppearance() {
        navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
    }
}
