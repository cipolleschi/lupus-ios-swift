//
//  GameLogic.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Katana
import Hydra
import Katana
import Tempura

enum GameLogic {
  struct CreateNewGame: AppSideEffect {
    func sideEffect(_ context: AppSideEffectContext) throws {
      let games = try await(context.dependencies.firebaseManager.getAllGames())
      let newGameCode = try await(context.dependencies.firebaseManager.createNewGame(games: games))
      context.dependencies.firebaseManager.subscribeToGame(roomCode: newGameCode)
      try await(context.dispatch(Show(Screen.createGame, animated: true)))
    }
  }


  struct JoinGame: AppSideEffect {
    let roomCode: String
    let playerName: String

    func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
      try await(context.dependencies.firebaseManager.joinGame(with: self.roomCode.lowercased(), playerName: self.playerName))
      try await(context.dependencies.firebaseManager.getAllGames())
      context.dependencies.firebaseManager.subscribeToGame(roomCode: self.roomCode.lowercased())
      try await(context.dispatch(UpdateCurrentPlayerData(name: self.playerName)))
    }
  }

  struct StartGame: AppSideEffect {
    func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
      guard let game = context.getState().currentGame else {
        let alertContext = SharedLogic.AlertContext(
          title: "Error",
          message: "There is no game that can be started",
          actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)]
        )
        try await(context.dispatch(SharedLogic.PresentAlert(alertContext: alertContext)))
        return
      }

      do {
        let roles = try context.dependencies.gameEngine.createRoles(players: game.players.count)
          .map { Models.Role(kind: $0) }
        let pairs = zip(game.players, roles)
        let assignments = [String: Models.Role].init(uniqueKeysWithValues: pairs)
        try await(context.dispatch(UpdateAssignments(assignments: assignments)))
        try await(context.dispatch(Show(Screen.assignments, animated: true)))
      } catch {
        let alertContext = SharedLogic.AlertContext(
          title: "Error",
          message: "Too few player to play",
          actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)]
        )
        try await(context.dispatch(SharedLogic.PresentAlert(alertContext: alertContext)))
        return
      }
    }
  }

  struct RemoveGame: AppSideEffect {

    func sideEffect(_ context: AppSideEffectContext) throws {
      guard let roomCode = context.getState().currentGame?.roomCode else {
        return
      }

      try await(context.dependencies.firebaseManager.removeGame(with: roomCode.lowercased()))
      try await(context.dispatch(Hide(Screen.createGame, animated: true)))
    }
  }

  struct LeaveGame: AppSideEffect {

    func sideEffect(_ context: AppSideEffectContext) throws {
      let state = context.getState()

      if
        let roomCode = state.currentGame?.roomCode,
        let playerName = state.currentPlayerUsername
      {
        try await(context.dependencies.firebaseManager.leaveGame(with: roomCode.lowercased(), playerName: playerName))
      }

      try await(context.dispatch(Hide(Screen.joinGame, animated: true)))
      try await(context.dispatch(UpdateCurrentPlayerData(name: nil)))
    }
  }

  struct GameDestroyed: AppSideEffect, StateObserverDispatchable {
    init?(prevState: State, currentState: State) {}

    func sideEffect(_ context: AppSideEffectContext) throws {
      let alertContext = SharedLogic.AlertContext(
        title: "Game canceled",
        message: "The game you were trying to join has been cancelled",
        actions: [
          UIAlertAction(title: "Ok", style: .default, handler: { action in
            DispatchQueue.global().async {
              try? await(context.dispatch(LeaveGame()))
              context.dependencies.firebaseManager.unsubscribe()
            }
          })
      ])
      try await(context.dispatch(SharedLogic.PresentAlert(alertContext: alertContext)))
    }
  }

  struct UpdateCurrentPlayerData: AppStateUpdater {
    let name: String?
    func updateState(_ state: inout AppState) {
      state.currentPlayerUsername = name
    }
  }

  struct UpdateAssignments: AppStateUpdater {
    let assignments: [String: Models.Role]
    func updateState(_ state: inout AppState) {
      state.currentGame?.roleAssignment = assignments
    }
  }
}

extension GameLogic {
  static var gameDeletedObserver: Katana.ObserverInterceptor.ObserverType.StateChangeObserver {
    return ObserverInterceptor.ObserverType.typedStateChange { (prevState: AppState, currState: AppState) in
      let prevGame = prevState.currentGame
      let currGame = currState.currentGame

      return prevGame != nil && currGame == nil
    }

  }
}
