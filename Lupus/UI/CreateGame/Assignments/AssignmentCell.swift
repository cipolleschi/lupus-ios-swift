//
//  AssignmentCell.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation
import Tempura
import BonMot
import PinLayout

struct AssignmentCellVM: ViewModel {

  let name: String
  let role: Models.Role

  init(name: String, role: Models.Role) {
    self.name = name
    self.role = role
  }

  var roleName: String {
    return self.role.kind.displayName
  }
}

class AssignmentCell: UICollectionViewCell, ModellableView {
  typealias VM = AssignmentCellVM
  static let reuseIdentifier = "\(AssignmentCellVM.self)"

  private let nameLabel = UILabel()
  private let roleLabel = UILabel()

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
    self.addSubview(self.roleLabel)

  }

  func style() { }

  func update(oldModel: VM?) {
    Style.styleSmallText(self.nameLabel, text: model?.name, alignment: .left)
    Style.styleSmallText(self.roleLabel, text: model?.roleName, alignment: .right)

    self.setNeedsLayout()
  }

  override func prepareForReuse() {
    self.model = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.nameLabel.pin
      .left(20)
      .right(to: self.edge.hCenter)
      .marginRight(20)
      .vCenter()
      .sizeToFit(.width)

    self.roleLabel.pin
      .left(to: self.edge.hCenter)
      .marginLeft(20)
      .right(20)
      .vCenter()
      .sizeToFit(.width)
  }
}
