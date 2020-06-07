//
//  GameEngine.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation

class GameEnginge {

  enum Error: Swift.Error {
    case notEnoughPlayer
  }

  func createRoles(players: Int) throws -> [Models.RoleKind] {
    guard players > 6 else {
      throw Error.notEnoughPlayer
    }

    let wolves = players / 5
    let possessed = players > 9
    let vampire = players >= 13
    let seer = true
    let `guard` = true
    let medium = players > 7
    let healer = possessed

    let mainRoles: [Models.RoleKind: Bool] = [
      .possessed : possessed,
      .vampire: vampire,
      .seer: seer,
      .guard: `guard`,
      .medium: medium,
      .healer: healer
    ]

    var villageRoles = Models.RoleKind.villageRoles

    // start with wolves
    var rolesToRet = [Models.RoleKind].init(repeating: .wolf, count: wolves)

    // add main roles
    for (role, inGame) in mainRoles {
      if inGame {
        rolesToRet.append(role)
      }
    }

    // add special village roles
    while rolesToRet.count < players && !villageRoles.isEmpty {
      let role = villageRoles.randomElement()!
      villageRoles.removeAll { $0 == role }
      rolesToRet.append(role)
    }

    // pad with villagers
    if rolesToRet.count < players && villageRoles.isEmpty {
      while rolesToRet.count < players {
        rolesToRet.append(.villager)
      }
    }

    return rolesToRet.shuffled()
  }
}
