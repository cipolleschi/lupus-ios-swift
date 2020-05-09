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
      print(newGameCode)
      context.dependencies.firebaseManager.subscribeToGame(roomCode: newGameCode)
      try await(context.dispatch(Show(Screen.createGame, animated: true)))
    }
  }
}
