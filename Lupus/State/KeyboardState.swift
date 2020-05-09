//
//  KeyboardState.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Katana

/// The state that manages the keyboard appearence
public struct KeyboardState: Equatable {

  /// The default animation duration for the keyboard appearence
  public static let defaultAnimationDuration: Double = 0.3

  /// The default animation curve for the keyboard appearence
  public static let defaultAnimationCurve: UIView.AnimationCurve = .easeInOut

  /// Enum that defines the possible visibility states of the keyboard
  public enum Visibility: Equatable {
    /// When the ketboard is not visible
    case hidden
    /// When the keyboard is visible. The `frame` parameter defines the
    /// portion of the screen occupied by the keyboard
    case visible(frame: CGRect)
  }

  /// Current visibility state of the keyboard.
  public internal(set) var visibility: Visibility = .hidden
  /// Current animation duration
  public internal(set) var animationDuration = defaultAnimationDuration
  /// Current animation curve
  public internal(set) var animationCurve = defaultAnimationCurve

  /// The current height of the keyboard. 0 if the keyboard is hidden
  public var height: CGFloat {
    switch self.visibility {
    case .hidden:
      return 0
    case .visible(let frame):
      return frame.height
    }
  }

  /// The animation options that can be used when animating the keyboard
  public var animationOptions: UIView.AnimationOptions {
    let curve: UIView.AnimationOptions = {
      switch self.animationCurve {
      case .easeIn: return .curveEaseIn
      case .easeOut: return .curveEaseOut
      case .easeInOut: return .curveEaseInOut
      case .linear: return .curveLinear
      @unknown default: return .curveEaseInOut
      }
    }()
    return [.beginFromCurrentState, curve]
  }
}
