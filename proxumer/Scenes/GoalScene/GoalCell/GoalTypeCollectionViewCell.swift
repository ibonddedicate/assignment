//
//  GoalTypeCollectionViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

class GoalTypeCollectionViewCell: UICollectionViewCell {
  
  static public let nibName = "GoalTypeCollectionViewCell"
  static public let identifier = "GoalTypeCollectionViewCell"
  
  @IBOutlet weak var goalBgView: UIView!
  @IBOutlet weak var goalIcon: UIImageView!
  @IBOutlet weak var goalTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
  }
  
  private func setupUI() {
    goalBgView.setCornerRadius()
    goalBgView.layer.borderColor = UIColor.proxumerRed.cgColor
    goalBgView.layer.borderWidth = 2
    goalBgView.dropShadow(edge: .all)
    goalTitle.setStyle(.smallBlack)
  }
  
  public func config(data: ChoiceModel, selected: Bool) {
    goalTitle.text = data.title
    goalIcon.image = data.icon.withRenderingMode(.alwaysTemplate)
    setSelectedState(selected)
  }
  
  private func setSelectedState(_ selected: Bool) {
    if selected {
      goalIcon.tintColor = UIColor.proxumerGreen
      goalBgView.layer.borderColor = UIColor.proxumerGreen.cgColor
    } else {
      goalIcon.tintColor = UIColor.proxumerRed
      goalBgView.layer.borderColor = UIColor.proxumerRed.cgColor
    }
  }
}
