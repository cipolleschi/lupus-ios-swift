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
  case alert
  case assignments
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
      }),
      .show(Screen.alert): .custom({ (id, from, animated, ctx, completion) in
        guard let context = ctx as? SharedLogic.AlertContext else {
          fatalError("Wrong context passed")
        }

        let vc = UIAlertController(title: context.title, message: context.message, preferredStyle: .alert)
        context.actions.forEach { vc.addAction($0) }
        self.present(vc, animated: animated, completion: completion)
      })
    ]
  }
}

extension CreateGameVC: RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier { return Screen.createGame.rawValue }

  var navigationConfiguration: [NavigationRequest : NavigationInstruction] {
    return  [
      .hide(Screen.createGame): .pop,
      .show(Screen.assignments): .push({ context in
        return AssignmentVC(store: self.store, connected: true)
      })
    ]
  }
}

extension JoinGameVC: RoutableWithConfiguration {
  var routeIdentifier: RouteElementIdentifier { return Screen.joinGame.rawValue }

  var navigationConfiguration: [NavigationRequest : NavigationInstruction] {
    return [
      .hide(Screen.joinGame): .pop
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
