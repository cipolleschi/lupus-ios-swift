//
//  PlayerCell.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura
import BonMot
import PinLayout

struct PlayerVM: ViewModel {

  let name: String

  init(name: String) {
    self.name = name
  }
}

class PlayerCell: UICollectionViewCell, ModellableView {
  typealias VM = PlayerVM
  static let reuseIdentifier = "\(PlayerVM.self)"

  private let nameLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.setup()
    self.style()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
    self.style()
  }

  func setup() {
    self.addSubview(self.nameLabel)

  }

  func style() { }

  func update(oldModel: VM?) {
    Style.styleSmallText(self.nameLabel, text: model?.name, centered: false)

    self.setNeedsLayout()
  }

  override func prepareForReuse() {
    self.model = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.nameLabel.pin
    .horizontally(20)
    .vCenter()
      .sizeToFit(.width)
  }
}
