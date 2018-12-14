//
//  FlexScrollView.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 18.05.18.
//  Copyright © 2018 nesiumdotcom. All rights reserved.
//

import Flex
import UIKit

fileprivate class FlexScrollContentView: FlexView {}

open class FlexScrollView: UIScrollView {
  public let contentView: FlexView

  public init() {
    self.contentView = FlexScrollContentView()
    super.init(frame: .zero)
    self.addSubview(self.contentView)

    self.flex.enabled = true
  }

  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func layoutSubviews() {
    super.layoutSubviews()

    let requiredSize = self.contentView.sizeThatFits(CGSize(
      width: self.bounds.width,
      height: CGFloat.greatestFiniteMagnitude
    ))
    self.contentSize = CGSize(width: self.bounds.width, height: requiredSize.height)
    self.contentView.frame = CGRect(origin: .zero, size: requiredSize)
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    return self.contentView.sizeThatFits(size)
  }
}
