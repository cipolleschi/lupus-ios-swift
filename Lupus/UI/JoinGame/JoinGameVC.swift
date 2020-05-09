//
//  JoinGameVC.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura

class JoinGameVC: ViewController<JoinGameView> {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func setupInteraction() {
    self.rootView.userDidTapJoinButton = { roomCode, playerName in
      guard let rc = roomCode, let pn = playerName else {
        return
      }
      self.dispatch(JoinGame(roomCode: rc, playerName: pn))
    }
  }
}
