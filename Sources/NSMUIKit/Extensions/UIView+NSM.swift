//
//  UIView+NSMForms.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 25/10/2016.
//  Copyright © 2016 nesiumdotcom. All rights reserved.
//

import UIKit

extension UIView {
  public func nsm_safeContentFrame(edgesForExtendedLayout: [UIRectEdge]) -> CGRect {
    let insets = UIEdgeInsets(
      top: edgesForExtendedLayout.contains(.top) ? 0 : self.safeAreaInsets.top,
      left: edgesForExtendedLayout.contains(.left) ? 0 : self.safeAreaInsets.left,
      bottom: edgesForExtendedLayout.contains(.bottom) ? 0 : self.safeAreaInsets.bottom,
      right: edgesForExtendedLayout.contains(.right) ? 0 : self.safeAreaInsets.right
    )
    return self.bounds.inset(by: insets)
  }

  open func nsm_invalidateIntrinsicContentSize() {
    self.setNeedsLayout()
    self.superview?.nsm_invalidateIntrinsicContentSize()
  }

  public var nsm_enclosingViewController: UIViewController? {
    var nextResponder = self.next

    while nextResponder != nil {
      if let ctrl = nextResponder as? UIViewController {
        return ctrl
      }
      nextResponder = nextResponder!.next
    }
    return nil
  }
}
