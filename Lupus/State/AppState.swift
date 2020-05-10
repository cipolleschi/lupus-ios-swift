//
//  AppState.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//

import Foundation
import Katana

struct AppState: State {
  var currentGame: Models.Game?
  var currentPlayerUsername: String?

  var keyboardState: KeyboardState = KeyboardState()
}
