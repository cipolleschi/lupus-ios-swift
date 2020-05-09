//
//  Game.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation

enum Models {}

extension Models {
  struct Game: JSONDictCodable {
    static let collectionName: String = "games"
    let roomCode: String
    var players: [String]
  }
}
