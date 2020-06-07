//
//  AssignmentView.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation
import Tempura
import PinLayout
import BonMot

struct AssignmentsVM: ViewModelWithState {
  let game: Models.Game
  
  init?(state: AppState) {
    guard let game = state.currentGame else {
      return nil
    }
    self.game = game
  }

  func assignmentCellVM(at indexPath: IndexPath) -> AssignmentCellVM {
    let player = self.game.players[indexPath.row]
    let role = self.game.roleAssignment[player]!
    return AssignmentCellVM(name: player, role: role)
  }
}

class AssignmentsView: UIView, ViewControllerModellableView {
  typealias VM = AssignmentsVM

  private lazy var playersTable: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

    collection.delegate = self
    collection.dataSource = self

    collection.register(AssignmentCell.self, forCellWithReuseIdentifier: AssignmentCell.reuseIdentifier)
    return collection
  }()

  private var continueButton = UIButton()

  func setup() {
    self.addSubview(self.playersTable)
    self.addSubview(self.continueButton)
  }

  func style() {
    self.backgroundColor = .white
    self.playersTable.backgroundColor = .white
    Style.styleMainButton(self.continueButton, text: "Continue")
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }
    self.playersTable.reloadData()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.continueButton.pin
      .horizontally(40)
      .height(50)
      .bottom(self.universalSafeAreaInsets.bottom + 10)

    self.playersTable.pin
    .all()
  }
}

extension AssignmentsView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model?.game.players.count ?? 0
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AssignmentCell.reuseIdentifier,
      for: indexPath
    ) as! AssignmentCell
    cell.model = self.model?.assignmentCellVM(at: indexPath)
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 30)
  }
}
