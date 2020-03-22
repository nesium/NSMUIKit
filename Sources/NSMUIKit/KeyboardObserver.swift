//
//  KeyboardObserver.swift
//  NSMUIKit
//
//  Created by Marc Bauer on 10.09.17.
//  Copyright © 2017 nesiumdotcom. All rights reserved.
//

import RxSwift
import UIKit

public class KeyboardObserver {
  /// The keyboard rect in window coordinates.
  public let observableKeyboardRect: Observable<CGRect?>
  public private(set) var keyboardRect: CGRect?

  public static let shared: KeyboardObserver = KeyboardObserver()

  private let disposeBag = DisposeBag()

  private enum KeyboardState {
    case hidden
    case visible(CGRect)
  }

  private enum KeyboardEvent {
    case show(CGRect)
    case hide
    case change(CGRect)
  }

  private init() {
    let subject: PublishSubject<KeyboardEvent> = PublishSubject()

    let extractRect: (Notification) -> (CGRect) = {
      ($0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    }

    NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillShowNotification,
      object: nil,
      queue: nil
    ) {
      subject.on(.next(.show(extractRect($0))))
    }

    NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: nil
    ) { _ in
      subject.on(.next(.hide))
    }

    NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillChangeFrameNotification,
      object: nil,
      queue: nil
    ) {
      subject.on(.next(.change(extractRect($0))))
    }

    let observable = subject
      .scan(.hidden, accumulator: { (state: KeyboardState, event: KeyboardEvent) -> KeyboardState in
        let result: KeyboardState

        switch (state, event) {
        case let (.hidden, .show(rect)):
          result = .visible(rect)
        case (.hidden, .hide):
          result = .hidden
        // This actually happens when an external keyboard is hooked up and a TextField looses
        // its responder status. So we only forward the change event, if the keyboard was
        // already visible.
        case (.hidden, .change):
          result = .hidden
        case let (.visible, .show(rect)):
          result = .visible(rect)
        case (.visible, .hide):
          result = .hidden
        case let (.visible, .change(rect)):
          result = .visible(rect)
        }

        switch result {
        case .hidden:
          return .hidden
        case let .visible(rect):
          if rect.isEmpty {
            return .hidden
          }
          return result
        }
      })
      .map { (state: KeyboardState) -> CGRect? in
        switch state {
        case .hidden:
          return nil
        case let .visible(rect):
          return rect
        }
      }
      .startWith(nil)
      .distinctUntilChanged { $0 == $1 }
      .replay(1)

    observable.connect()
      .disposed(by: self.disposeBag)

    self.observableKeyboardRect = observable

    observable
      .subscribe(onNext: { [unowned self] in
        self.keyboardRect = $0
      })
      .disposed(by: self.disposeBag)
  }
}
