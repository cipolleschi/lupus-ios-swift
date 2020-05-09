//
//  AppNavigation.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//

import Foundation
import Tempura

enum Screen: String {
  case startMenu
  case createGame
  case joinGame
}

extension StartMenuNC: RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier { return Screen.startMenu.rawValue }

  var navigationConfiguration: [NavigationRequest : NavigationInstruction] {
    return [
      .show(Screen.createGame): .push({ context in
        return CreateGameVC(store: self.store, connected: true)
      }),
      .show(Screen.joinGame): .push({ context in
        return JoinGameVC(store: self.store, connected: true)
      })
    ]
  }
}

extension CreateGameVC: RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier { return Screen.createGame.rawValue }

  var navigationConfiguration: [NavigationRequest : NavigationInstruction] {
    return  [
      .hide(Screen.createGame): .pop
    ]
  }
}

extension JoinGameVC: RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier { return Screen.joinGame.rawValue }

  var navigationConfiguration: [NavigationRequest : NavigationInstruction] {
    return [
      .hide(Screen.createGame): .pop
    ]
  }
}

extension AppDelegate: RootInstaller {
  func installRoot(
    identifier: RouteElementIdentifier,
    context: Any?,
    completion: @escaping Navigator.Completion
  ) -> Bool {
    guard let screen = Screen(rawValue: identifier) else {
      return false
    }

    switch screen {
    case .startMenu:
      let vc = StartMenuVC(store: self.store, connected: true)
      let nc = StartMenuNC(store: self.store)
      nc.setViewControllers([vc], animated: true)
      self.window?.rootViewController = nc
      return true
    default:
      return false
    }
  }
}
