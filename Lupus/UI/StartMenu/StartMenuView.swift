//
//  StartMenuView.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//

import Foundation
import Tempura
import PinLayout
import BonMot

struct StartMenuVM: ViewModelWithState {

  init(state: AppState) {

  }
}

class StartMenuView: UIView, ViewControllerModellableView {
  typealias VM = StartMenuVM

  private var startGameButton = UIButton()
  private var joinGameButton = UIButton()
  private var rolesButton = UIButton()
  private var rulesButton = UIButton()

  var userDidTapStartGame: Interaction?
  var userDidTapJoinGame: Interaction?
  var userDidTapRoles: Interaction?
  var userDidTapRules: Interaction?


  func setup() {
    self.addSubview(self.startGameButton)
    self.addSubview(self.joinGameButton)
    self.addSubview(self.rolesButton)
    self.addSubview(self.rulesButton)

    self.startGameButton.addTarget(self, action: #selector(self.startGameButtonTapped(_:)), for: .touchUpInside)
    self.joinGameButton.addTarget(self, action: #selector(self.joinGameButtonTapped(_:)), for: .touchUpInside)
    self.rolesButton.addTarget(self, action: #selector(self.rolesButtonTapped(_:)), for: .touchUpInside)
    self.rulesButton.addTarget(self, action: #selector(self.rulesButtonTapped(_:)), for: .touchUpInside)
  }

  @objc func startGameButtonTapped(_ control: UIControl) {
    self.userDidTapStartGame?()
  }

  @objc func joinGameButtonTapped(_ control: UIControl) {
    self.userDidTapJoinGame?()

  }

  @objc func rolesButtonTapped(_ control: UIControl) {
    self.userDidTapRoles?()
  }

  @objc func rulesButtonTapped(_ control: UIControl) {
    self.userDidTapRules?()
  }


  func style() {
    self.backgroundColor = .white
    Style.styleMainButton(self.startGameButton, text: "Start Game")
    Style.styleMainButton(self.joinGameButton, text: "Join Game")
    Style.styleMainButton(self.rolesButton, text: "Roles")
    Style.styleMainButton(self.rulesButton, text: "Rules")
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.joinGameButton.pin
      .vCenter()
      .marginBottom(35)
      .horizontally(40)
      .height(Style.buttonHeight)

    self.rolesButton.pin
      .vCenter()
      .marginTop(35)
      .horizontally(40)
      .height(Style.buttonHeight)

    self.startGameButton.pin
      .above(of: self.joinGameButton)
      .marginBottom(20)
      .horizontally(40)
      .height(Style.buttonHeight)

    self.rulesButton.pin
      .below(of: rolesButton)
      .horizontally(40)
      .marginTop(20)
      .height(Style.buttonHeight)

  }
}
