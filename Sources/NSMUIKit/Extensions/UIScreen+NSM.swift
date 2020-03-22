//
//  UIScreen+NSM.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 19/01/2017.
//  Copyright © 2017 nesiumdotcom. All rights reserved.
//

import UIKit

public extension UIScreen {
  static func nsm_floor(_ value: CGFloat) -> CGFloat {
    (value * UIScreen.main.scale).rounded(.down) / UIScreen.main.scale
  }

  static func nsm_round(_ value: CGFloat) -> CGFloat {
    (value * UIScreen.main.scale).rounded(.toNearestOrAwayFromZero) / UIScreen.main.scale
  }

  static func nsm_ceil(_ value: CGFloat) -> CGFloat {
    (value * UIScreen.main.scale).rounded(.up) / UIScreen.main.scale
  }

  var nsm_pixel: CGFloat {
    1.0 / self.scale
  }
}
