//
//  PlayerTable.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura
import PinLayout
import BonMot

struct PlayersVM: ViewModel {

  let players: [String]

  init(players: [String]) {
    self.players = players
  }

  func shouldReloadData(oldModel: PlayersVM?) -> Bool {
    guard let oldModel = oldModel else {
      return true
    }

    return self.players != oldModel.players
  }

  func playerCellViewModel(at indexPath: IndexPath) -> PlayerVM? {
    let name = self.players[indexPath.row]
    return PlayerVM(name: name)
  }
}

class PlayersTable: UIView, ModellableView, UICollectionViewDataSource, UICollectionViewDelegate {
  typealias VM = PlayersVM

  lazy var tableView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

    collection.delegate = self
    collection.dataSource = self

    collection.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier)
    return collection
  }()

  func setup() {
    self.addSubview(self.tableView)
  }

  func style() {
    self.backgroundColor = .white
    self.tableView.backgroundColor = .white
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }

    if model.shouldReloadData(oldModel: oldModel) {
      self.tableView.reloadData()
    }

    self.setNeedsLayout()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.tableView.frame = self.bounds
  }
}

extension PlayersTable {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model?.players.count ?? 0
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

}
