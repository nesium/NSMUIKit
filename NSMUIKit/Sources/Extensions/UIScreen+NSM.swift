//
//  UIScreen+NSM.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 19/01/2017.
//  Copyright © 2017 nesiumdotcom. All rights reserved.
//

import UIKit

public extension UIScreen {
  public static func nsm_floor(_ value: CGFloat) -> CGFloat {
    return (value * UIScreen.main.scale).rounded(.down) / UIScreen.main.scale
  }

  public static func nsm_round(_ value: CGFloat) -> CGFloat {
    return (value * UIScreen.main.scale).rounded(.toNearestOrAwayFromZero) / UIScreen.main.scale
  }

  public static func nsm_ceil(_ value: CGFloat) -> CGFloat {
    return (value * UIScreen.main.scale).rounded(.up) / UIScreen.main.scale
  }

  public var nsm_pixel: CGFloat {
    return 1.0 / self.scale
  }
}
