//
//  CreateGameView.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura
import PinLayout
import BonMot

struct CreateGameVM: ViewModelWithState {
  let game: Models.Game

  init?(state: AppState) {
    guard let game = state.currentGame else {
      return nil
    }
    self.game = game
  }

  var connectedPlayersText: String {
    return "Connected Players: \(self.game.players.count)"
  }

  var isStartGameEnabled: Bool {
    return self.game.players.count > 7
  }

  var roomCode: String {
    return game.roomCode
  }

  func playerCellViewModel(at indexPath: IndexPath) -> PlayerVM? {
    let name = self.game.players[indexPath.row]
    return PlayerVM(name: name)
  }


}

class CreateGameView: UIView, ViewControllerModellableView {
  typealias VM = CreateGameVM

  private let roomCodeTitleLabel = UILabel()
  private let roomCodeLabel = UILabel()
  private let numberOfConnectedPlayers = UILabel()

  private lazy var playersTable: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

    collection.delegate = self
    collection.dataSource = self

    collection.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier)
    return collection
  }()
  private var startGameButton = UIButton()

  var userDidTapStartGameButton: Interaction?

  func setup() {
    self.addSubview(self.roomCodeTitleLabel)
    self.addSubview(self.roomCodeLabel)
    self.addSubview(self.numberOfConnectedPlayers)
    self.addSubview(self.playersTable)
    self.addSubview(self.startGameButton)

    self.startGameButton.addTarget(self, action: #selector(self.startGameButtonTapped(_:)), for: .touchUpInside)
  }

  @objc func startGameButtonTapped(_ control: UIControl) {
    self.userDidTapStartGameButton?()
  }

  func style() {
    self.backgroundColor = .white
    self.playersTable.backgroundColor = .white
    Style.styleSmallText(self.roomCodeTitleLabel, text: "Room Code:")
    Style.styleMainButton(self.startGameButton, text: "Start Game")
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }
    Style.styleBigText(self.roomCodeLabel, text: model.roomCode)
    Style.styleSmallText(self.numberOfConnectedPlayers, text: model.connectedPlayersText)
    self.startGameButton.isEnabled = model.isStartGameEnabled
    if self.model?.game.players != oldModel?.game.players {
      self.playersTable.reloadData()
    }

    self.setNeedsLayout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()

    self.roomCodeTitleLabel.pin
      .horizontally(20)
      .top(self.universalSafeAreaInsets.top + 20)
      .sizeToFit(.width)

    self.roomCodeLabel.pin
      .horizontally(20)
      .below(of: self.roomCodeTitleLabel)
      .marginTop(10)
      .sizeToFit(.width)

    self.numberOfConnectedPlayers.pin
      .horizontally(20)
      .below(of: self.roomCodeLabel)
      .marginTop(10)
      .sizeToFit(.width)

    self.startGameButton.pin
      .horizontally(40)
      .height(Style.buttonHeight)
      .bottom(self.universalSafeAreaInsets.bottom + 20)

    self.playersTable.pin
    .horizontally()
      .top(to: self.numberOfConnectedPlayers.edge.bottom)
    .marginTop(10)
      .bottom(to: self.startGameButton.edge.top)
    .marginBottom(10)
  }
}

extension CreateGameView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model?.game.players.count ?? 0
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PlayerCell.reuseIdentifier,
      for: indexPath
    ) as! PlayerCell
    cell.model = self.model?.playerCellViewModel(at: indexPath)
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 30)
  }
}
