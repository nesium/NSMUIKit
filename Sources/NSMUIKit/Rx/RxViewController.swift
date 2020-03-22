//
//  RxViewController.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 01.01.18.
//  Copyright © 2018 nesiumdotcom. All rights reserved.
//

import RxSwift
import UIKit

open class RxViewController: UIViewController {
  public var rx: ViewControllerRxEvents {
    self.rxPublisher
  }

  private lazy var rxPublisher = ViewControllerRxEventsPublisher()

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.rxPublisher.viewWillAppearSubject.onNext(animated)
  }

  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.rxPublisher.viewWillDisappearSubject.onNext(animated)

    if self.isMovingFromParent || self.isBeingDismissed {
      self.rxPublisher.isBeingRemovedOrDismissedSubject.onNext(animated)
    }
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.rxPublisher.viewDidAppearSubject.onNext(animated)
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.rxPublisher.viewDidDisappearSubject.onNext(animated)
  }
}
