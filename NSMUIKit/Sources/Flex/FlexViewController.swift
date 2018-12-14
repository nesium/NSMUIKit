//
//  FlexViewController.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 02.11.17.
//  Copyright © 2017 nesiumdotcom. All rights reserved.
//

import Flex
import UIKit

open class FlexViewController: RxViewController {
  public var nsm_minimumPadding: UIEdgeInsets = .zero {
    didSet {
      guard self.isViewLoaded else {
        return
      }
      (self.view as! FlexViewControllerContainerView).minimumPadding = self.nsm_minimumPadding
    }
  }

  public var nsm_edgesForExtendedLayout: UIRectEdge = [] {
    didSet {
      guard self.isViewLoaded else {
        return
      }
      (self.view as! FlexViewControllerContainerView).edgesForExtendedLayout =
        self.nsm_edgesForExtendedLayout
    }
  }

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  final override public func loadView() {
    let view = FlexViewControllerContainerView(frame: UIScreen.main.bounds)
    self.view = view
    view.flex.direction = .column
    view.edgesForExtendedLayout = self.nsm_edgesForExtendedLayout
    view.minimumPadding = self.nsm_minimumPadding
  }
}



fileprivate class FlexViewControllerContainerView: FlexView {
  var minimumPadding: UIEdgeInsets = .zero {
    didSet {
      self.updatePadding()
    }
  }

  var edgesForExtendedLayout: UIRectEdge = [] {
    didSet {
      if self.edgesForExtendedLayout != oldValue {
        self.setNeedsLayout()
      }
    }
  }

  init(frame: CGRect) {
    super.init()
    self.frame = frame
    self.flex.enabled = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.flex.layoutSubviews()
  }

  @available(iOS 11.0, *)
  override func safeAreaInsetsDidChange() {
    super.safeAreaInsetsDidChange()
    self.updatePadding()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return self.flex.sizeThatFits(size)
  }

  private func updatePadding() {
    var padding = self.safeAreaInsets

    if self.edgesForExtendedLayout.contains(.top) {
      padding.top = 0
    }
    if self.edgesForExtendedLayout.contains(.left) {
      padding.left = 0
    }
    if self.edgesForExtendedLayout.contains(.bottom) {
      padding.bottom = 0
    }
    if self.edgesForExtendedLayout.contains(.right) {
      padding.right = 0
    }

    self.flex.style {
      $0.paddingTop = .point(max(padding.top, self.minimumPadding.top))
      $0.paddingLeft = .point(max(padding.left, self.minimumPadding.left))
      $0.paddingBottom = .point(max(padding.bottom, self.minimumPadding.bottom))
      $0.paddingRight = .point(max(padding.right, self.minimumPadding.right))
    }

    self.setNeedsLayout()
  }
}
