//
//  KeyboardLogic.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Katana

enum KeyboardLogic {
  /// This action is invoked every time the keyboard is presented.
  /// It saves the keyboard frame in the state so that it can be used to properly layout elements in each view.
  struct KeyboardWillShow: AppStateUpdater, NotificationObserverDispatchable {
    private let frame: CGRect
    private let animationDuration: Double
    private let animationCurve: UIView.AnimationCurve

    init?(notification: Notification) {
      guard
        notification.name == UIResponder.keyboardWillShowNotification,
        let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
        let animationCurveInt = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
        let animationCurve = UIView.AnimationCurve(rawValue: animationCurveInt)
        else {
          return nil
      }

      self.frame = frame
      self.animationDuration = animationDuration
      self.animationCurve = animationCurve
    }

    func updateState(_ state: inout AppState) {
      state.keyboardState = KeyboardState(
        visibility: .visible(frame: self.frame),
        animationDuration: self.animationDuration,
        animationCurve: self.animationCurve
      )
    }
  }

  /// Keyboard is dismissed.
  struct KeyboardWillHide: AppStateUpdater, NotificationObserverDispatchable {
    init?(notification: Notification) {
      guard notification.name == UIResponder.keyboardWillHideNotification else {
        return nil
      }
    }

    func updateState(_ state: inout AppState) {
      state.keyboardState.visibility = .hidden
    }
  }
}
