//
//  FirebaseManager.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Firebase
import Hydra
import Katana

class FirebaseManager {
  enum Error: Swift.Error {
    case noCollectionFound
    case impossibleToCreateRoom
    case gameNotFound
    case documentNotFound
    case playerExists
    case playerNotExists
  }

  private var firestoreDB: Firestore!
  private var dispatch: PromisableStoreDispatch!
  private let availableSymbols = "abcdefghijklmnopqrstuvwxyz0123456789"
  private var snapshotListener: ListenerRegistration?

  init() {}

  func start(firestoreDB: Firestore, dispatch: @escaping PromisableStoreDispatch) {
    self.firestoreDB = firestoreDB
    self.dispatch = dispatch
  }

  func startNewGame() {

  }

  func getAllGames() -> Promise<[Models.Game]> {
    return Promise<[Models.Game]>(in: .background) { resolve, reject, _ in
      self.firestoreDB.collection(Models.Game.collectionName).getDocuments { snapshot, error in
        if let err = error {
          reject(err)
          return
        }

        guard let content = snapshot else {
          reject(Error.noCollectionFound)
          return
        }

        let games = content.documents.compactMap {
          try? Models.Game(jsonInfo: $0.data())
        }
        resolve(games)
      }
    }
  }

  func getGame(roomCode: String) -> Promise<Models.Game> {
    return Promise<Models.Game>(in: .background) { resolve, reject, _ in
      self.firestoreDB.collection(Models.Game.collectionName).whereField("room_code", isEqualTo: roomCode)
    }
  }

  func createNewGame(games: [Models.Game]) throws -> Promise<String> {
    return Promise<String>(in: .background) { resolve, reject, _ in
      do {
        let code = try self.createRoomCode(games: games)
        let game = Models.Game(roomCode: code, players: [])
        self.firestoreDB.collection(Models.Game.collectionName)
          .addDocument(data: try game.jsonInfo()) { error in
          if let err = error {
            reject(err)
          }
          resolve(code)
        }
      } catch {
        reject(error)
      }
    }
  }

  func joinGame(with roomCode: String, playerName: String) throws -> Promise<Void> {
    return Promise<Void>(in: .background) { resolve, reject, _ in
      self.firestoreDB.collection(Models.Game.collectionName)
        .whereField("room_code", isEqualTo: roomCode).getDocuments { snapshot, error in
          if let err = error {
            reject(err)
            return
          }

          guard
            let content = snapshot,
            content.documents.count == 1,
            let docId = content.documents.first?.documentID,
            let gameData = content.documents.first?.data(),
            var game = try? Models.Game(jsonInfo: gameData)
          else {
            reject(Error.gameNotFound)
            return
          }

          guard !game.players.contains(playerName) else {
            reject(Error.playerExists)
            return
          }

          game.players.append(playerName)
          self.firestoreDB.collection(Models.Game.collectionName)
            .document(docId).setData(try! game.jsonInfo(), merge: true) { error in
              if let err = error {
                reject(err)
                return
              }
              resolve(())
          }
      }
    }
  }

  func leaveGame(with roomCode: String, playerName: String) throws -> Promise<Void> {
    return Promise<Void>(in: .background) { resolve, reject, _ in
      self.firestoreDB.collection(Models.Game.collectionName)
      .whereField("room_code", isEqualTo: roomCode).getDocuments { snapshot, error in
        if let err = error {
          reject(err)
          return
        }

        guard
          let content = snapshot,
          content.documents.count == 1,
          let docId = content.documents.first?.documentID,
          let gameData = content.documents.first?.data(),
          var game = try? Models.Game(jsonInfo: gameData)
        else {
          reject(Error.gameNotFound)
          return
        }
        guard game.players.contains(playerName) else {
          reject(Error.playerNotExists)
          return
        }

        game.players.removeAll { $0 == playerName }
        self.firestoreDB.collection(Models.Game.collectionName)
          .document(docId).setData(try! game.jsonInfo(), merge: true) { error in
            if let err = error {
              reject(err)
              return
            }
            self.snapshotListener?.remove()
            resolve(())
        }
      }
    }
  }

  func removeGame(with roomCode: String) throws -> Promise<Void> {
    return Promise<Void>(in: .background) { resolve, reject, _ in
      self.firestoreDB.collection(Models.Game.collectionName)
        .whereField("room_code", isEqualTo: roomCode).getDocuments { snapshot, error in
          if let err = error {
            reject(err)
            return
          }

          guard
            let content = snapshot,
            content.documents.count == 1,
            let docId = content.documents.first?.documentID
          else {
            reject(Error.documentNotFound)
            return
          }

          self.firestoreDB.collection(Models.Game.collectionName).document(docId).delete()
          self.snapshotListener?.remove()
          resolve(())
      }
    }
  }

  func unsubscribe() {
    self.snapshotListener?.remove()
  }
  
  func subscribeToGame(roomCode: String) {
    self.snapshotListener = self.firestoreDB.collection(Models.Game.collectionName)
      .whereField("room_code", isEqualTo: roomCode).addSnapshotListener { snapshot, error in
        if let err = error {
          print("Error with an update: \(err)")
          return
        }

        guard
          let data = snapshot?.documents.first?.data(),
          let game = try? Models.Game(jsonInfo: data)
        else {
          _ = self.dispatch(GameDataReceived(game: nil))
          return
        }

        _ = self.dispatch(GameDataReceived(game: game))

    }
  }

  fileprivate func createRoomCode(games: [Models.Game]) throws -> String {
    let set = Set<String>(games.map { $0.roomCode })
    for _ in 0..<1000 {
      let roomCode = createRandomRoomCode()
      if !set.contains(roomCode) {
        return roomCode
      }
    }
    throw Error.impossibleToCreateRoom
  }


  fileprivate func createRandomRoomCode() -> String {
    let charCode = (0..<4).map { _ in availableSymbols.randomElement()! }
    return String(charCode)
  }
}


struct GameDataReceived: AppSideEffect {
  let game: Models.Game?

  func sideEffect(_ context: AppSideEffectContext) throws {
    try await(context.dispatch(UpdateCurrentGame(game: self.game)))
  }
}

struct UpdateCurrentGame: AppStateUpdater {
  let game: Models.Game?
  
  func updateState(_ state: inout AppState) {
    state.currentGame = self.game
  }
}
