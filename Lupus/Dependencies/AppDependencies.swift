//
//  AppDependencies.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//

import Foundation
import Katana
import Tempura
import Firebase
import Hydra

class AppDependencies: SideEffectDependencyContainer,
NavigationProvider {

  let dispatch: PromisableStoreDispatch
  let getState: GetState
  let navigator: Navigator
  let firebaseManager: FirebaseManager

  required init(dispatch: @escaping PromisableStoreDispatch, getState: @escaping GetState) {
    self.dispatch = dispatch
    self.getState = getState
    self.navigator = Navigator()
    self.firebaseManager = FirebaseManager()

    FirebaseApp.configure()
    self.firebaseManager.start(firestoreDB: Firestore.firestore(), dispatch: dispatch)

    dispatch(JoinGame(roomCode: "t3fi", playerName: "FEC")).void
  }
}

struct JoinGame: AppSideEffect {
  let roomCode: String
  let playerName: String

  func sideEffect(_ context: SideEffectContext<AppState, AppDependencies>) throws {
    try await(context.dependencies.firebaseManager.joinGame(with: roomCode, playerName: playerName))
    let games2 = try await(context.dependencies.firebaseManager.getAllGames())
    print(games2)
    context.dependencies.firebaseManager.subscribeToGame(roomCode: roomCode)
  }
}
