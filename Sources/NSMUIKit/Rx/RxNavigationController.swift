//
//  RxNavigationController.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 02.12.17.
//  Copyright © 2017 nesiumdotcom. All rights reserved.
//

import RxSwift
import UIKit

public protocol ViewControllerRxEvents {
  var viewWillApear: Observable<Bool> { get }
  var viewWillDisappear: Observable<Bool> { get }
  var viewDidAppear: Observable<Bool> { get }
  var viewDidDisappear: Observable<Bool> { get }

  var isBeingRemovedOrDismissed: Observable<Bool> { get }
}

internal class ViewControllerRxEventsPublisher: ViewControllerRxEvents {
  var viewWillApear: Observable<Bool> { self.viewWillAppearSubject }
  var viewWillDisappear: Observable<Bool> { self.viewWillDisappearSubject }
  var viewDidAppear: Observable<Bool> { self.viewDidAppearSubject }
  var viewDidDisappear: Observable<Bool> { self.viewDidDisappearSubject }
  var isBeingRemovedOrDismissed: Observable<Bool> { self.isBeingRemovedOrDismissedSubject }

  lazy var viewWillAppearSubject: PublishSubject<Bool> = PublishSubject()
  lazy var viewWillDisappearSubject: PublishSubject<Bool> = PublishSubject()
  lazy var viewDidAppearSubject: PublishSubject<Bool> = PublishSubject()
  lazy var viewDidDisappearSubject: PublishSubject<Bool> = PublishSubject()
  lazy var isBeingRemovedOrDismissedSubject: PublishSubject<Bool> = PublishSubject()
}

open class RxNavigationController: UINavigationController {
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

  open override var preferredStatusBarStyle: UIStatusBarStyle {
    self.topViewController?.preferredStatusBarStyle ?? .default
  }
}
