//
//  UserDefaultsMocked.swift
//  SpotifyAlbumsTests
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

class UserDefaultsMocked : UserDefaults {

  convenience init() {
    self.init(suiteName: "Mock User Defaults")!
  }

  override init?(suiteName suitename: String?) {
    UserDefaults().removePersistentDomain(forName: suitename!)
    super.init(suiteName: suitename)
  }

}
