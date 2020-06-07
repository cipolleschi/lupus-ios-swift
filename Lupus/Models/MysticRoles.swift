//
//  MysticRoles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation
extension Models {
  struct Seer: Role, Mystic {
    var kind: Models.RoleKind { return .seer }

    var aura: Models.Aura { return .good }

    var powerDescription: String {
      return """
      During the night, she can chose a person that is still in play.
      The master will tell her whether her aura is good or evil.
      """
    }
  }

  struct Medium: Role, Mystic {
    var kind: Models.RoleKind { return .medium }

    var aura: Models.Aura { return .good }

    var powerDescription: String {
      return """
      During the night, she can chose a person that has been killed.
      The master will tell her whether her aura was good or evil.
      """
    }

  }

  struct Guard: Role, Mystic {
    var kind: Models.RoleKind { return .guard }

    var aura: Models.Aura { return .good }

    var powerDescription: String {
      return """
      During the night, she can chose a person and protect her from the powers of the night.
      That person cannot be killed nor can be transformed into a vampire. The guard cannot protect herself.
      """
    }

  }

  struct Healer: Role, Mystic {
    var kind: Models.RoleKind { return .healer }

    var aura: Models.Aura { return .good }

    var powerDescription: String {
      return """
      During the night, the master will tell her about all the people that died.
      Once per game, she can decide to save her from dying. The healer cannot heal herself.
      """
    }

  }
}
