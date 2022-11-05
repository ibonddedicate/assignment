//
//  GoalCollectionViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
  
  static public let nibName = "GoalCollectionViewCell"
  static public let identifier = "GoalCollectionViewCell"
  
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var currentAmountLabel: UILabel!
  @IBOutlet weak var goalAmountLabel: UILabel!
  
  @IBOutlet weak var progressBgView: UIView!
  @IBOutlet weak var progressView: UIView!
  @IBOutlet weak var progressWidth: NSLayoutConstraint!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var dayLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
  }
  
  private func setupUI() {
    bgView.setCornerRadius()
    bgView.layer.borderWidth = 2
    bgView.dropShadow(edge: .all, shadowSpace: 0)
    
    currentAmountLabel.setStyle(.mediumRed)
    goalAmountLabel.setStyle(.smallBlack)
    titleLabel.setStyle(.mediumBlack)
    dayLabel.setStyle(.smallBlack)
    progressBgView.setCornerRadius(radius: 4)
  }
  
  public func config(data: GoalModel) {
    iconImage.image               = data.icon.withRenderingMode(.alwaysTemplate)
    iconImage.tintColor           = UIColor.proxumerRed
    progressView.backgroundColor  = UIColor.proxumerRed
    currentAmountLabel.text       = "\(data.currentAmount.addSeperator()) THB"
    goalAmountLabel.text          = "\(data.goalAmount.addSeperator()) THB"
    titleLabel.text               = data.title
    dayLabel.text                 = "\(data.remainingDays) days left"
    
    layoutIfNeeded()
    
    let percentage = Double(data.currentAmount) / Double(data.goalAmount)
    let width = progressBgView.frame.width
    let progressViewWidth = percentage * width
    progressWidth.constant = progressViewWidth
    
    percentage >= 0.5 ? makePositive() : makeNegative()
  }
  
  private func makePositive() {
    bgView.layer.borderColor = UIColor.proxumerGreen.cgColor
    statusLabel.setStyle(.smallGreen)
    statusLabel.text = "Good"
  }
  
  private func makeNegative() {
    bgView.layer.borderColor = UIColor.proxumerRed.cgColor
    statusLabel.setStyle(.smallRed)
    statusLabel.text = "Unhappy"
  }
}
