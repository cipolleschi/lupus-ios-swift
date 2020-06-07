//
//  Role.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation

protocol Role: JSONDictCodable {
  var kind: Models.RoleKind { get }
  var aura: Models.Aura { get }
  var powerDescription: String { get }

}

protocol Mystic {

}

protocol Vampirable {
  var isMinorVampire: Bool { get set}
}

extension Models {
  enum Aura {
    case good
    case evil
  }

  enum RoleKind {
    // wolves
    case wolf
    case possessed
    // vampire
    case vampire
    // mystics
    case seer
    case medium
    case `guard`
    case healer
    // town
    case mayor
    case bartender
    case priest
    case sinner
    case boccaDiRose
    case orator
    case lawyer
    case hero
    case progeny
    case hermit
    case merchant
  }
}

struct RoleFactory {
  static func createRole(from kind: Models.RoleKind) -> Role {
    switch kind {
    case .wolf:
      return Models.Wolf()
    case .possessed:
      return Models.Possessed()
    case .vampire:
      return Models.Vampire()
    case .seer:
      return Models.Seer()
    case .medium:
      return Models.Medium()
    case .guard:
      return Models.Guard()
    case .healer:
      return Models.Healer()
    case .mayor:
      return Models.Mayor()
    case .bartender:
      return Models.Bartender()
    case .priest:
      return Models.Priest()
    case .sinner:
      return Models.Sinner()
    case .boccaDiRose:
      return Models.BoccaDiRose()
    case .orator:
      return Models.Orator()
    case .lawyer:
      return Models.Lawyer()
    case .hero:
      return Models.Hero()
    case .progeny:
      return Models.Progeny()
    case .hermit:
      return Models.Hermit()
    case .merchant:
      return Models.Merchant()
    }
  }
}

