//
//  GameLogic.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Katana
import Hydra
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

      guard
        let roomCode = state.currentGame?.roomCode,
        let playerName = state.currentPlayerUsername
      else {
        return
      }

      try await(context.dependencies.firebaseManager.leaveGame(with: roomCode.lowercased(), playerName: playerName))
      try await(context.dispatch(Hide(Screen.createGame, animated: true)))
    }
  }

  struct UpdateCurrentPlayerData: AppStateUpdater {
    let name: String
    func updateState(_ state: inout AppState) {
      state.currentPlayerUsername = name
    }
  }
}
