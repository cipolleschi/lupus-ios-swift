//
//  JoinGameView.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura
import PinLayout
import BonMot

struct JoinGameVM: ViewModelWithState {
  let game: Models.Game?

  init(state: AppState) {
    self.game = state.currentGame
  }

  var joinAlpha: CGFloat {
    return game == nil ? 1.0 : 0.0
  }
}

class JoinGameView: UIView, ViewControllerModellableView {
  typealias VM = JoinGameVM

  private let roomCodeTitleLabel = UILabel()
  private var roomCodeText = UITextField()
  private let playerNameLabel = UILabel()
  private let playerNameText = UITextField()
  private var joinButton = UIButton()

  var userDidTapJoinButton: ((String?, String?) -> ())?

  func setup() {
    self.addSubview(self.roomCodeTitleLabel)
    self.addSubview(self.roomCodeText)
    self.addSubview(self.playerNameLabel)
    self.addSubview(self.playerNameText)
    self.addSubview(self.joinButton)

    roomCodeText.becomeFirstResponder()
    roomCodeText.placeholder = "room code..."
    playerNameText.placeholder = "your name..."

    self.joinButton.addTarget(self, action: #selector(self.joinButtonTapped(_:)), for: .touchUpInside)
  }

  @objc func joinButtonTapped(_ control: UIControl) {
    self.userDidTapJoinButton?(self.roomCodeText.text, self.playerNameText.text)
  }

  func style() {
    self.backgroundColor = .white
    Style.styleSmallText(self.roomCodeTitleLabel, text: "Insert Room Code:")
    Style.styleSmallText(self.playerNameLabel, text: "Insert Your Name:")
    Style.styleMainButton(self.joinButton, text: "Join Game")
    self.roomCodeText.textAlignment = .center
    self.playerNameText.textAlignment = .center
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }

    self.joinButton.alpha = model.joinAlpha
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.roomCodeTitleLabel.pin
    .horizontally(20)
      .top(self.universalSafeAreaInsets.top + 20)
      .sizeToFit(.width)

    self.roomCodeText.pin
      .horizontally(20)
      .below(of: self.roomCodeTitleLabel)
      .marginTop(10)
      .height(40)

    self.playerNameLabel.pin
      .horizontally(20)
      .below(of: self.roomCodeText)
      .marginTop(10)
      .sizeToFit(.width)

    self.playerNameText.pin
      .horizontally(20)
      .below(of: self.playerNameLabel)
      .marginTop(10)
      .height(40)

    self.joinButton.pin
      .below(of: playerNameText)
      .marginTop(10)
      .horizontally(40)
      .height(Style.buttonHeight)

  }
}
