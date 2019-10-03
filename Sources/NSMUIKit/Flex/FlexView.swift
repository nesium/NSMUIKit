//
//  FlexView.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 17.05.18.
//  Copyright © 2018 nesiumdotcom. All rights reserved.
//

import UIKit
import Flex

open class FlexView: UIView {
  public init() {
    super.init(frame: .zero)
    self.flex.enabled = true
  }

  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    self.flex.layoutSubviews()
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    // sizeThatFits(_:) will only be called if we do not have a configured width and height.
    // This means we rely on measuring our children. If however we do not have any children
    // Yoga calls in our measure method over and over, leading to an infinite recursion.
    guard !self.subviews.isEmpty else {
      return .zero
    }
    return self.flex.sizeThatFits(size)
  }
}
