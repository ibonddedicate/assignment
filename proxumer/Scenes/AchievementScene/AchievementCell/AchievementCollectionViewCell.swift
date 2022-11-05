//
//  AchievementCollectionViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

class AchievementCollectionViewCell: UICollectionViewCell {

  static public let nibName = "AchievementCollectionViewCell"
  static public let identifier = "AchievementCollectionViewCell"
  
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  
  private func setupUI() {
    bgView.layer.borderWidth = 1
    bgView.layer.borderColor = UIColor.proxumerRed.cgColor
    titleLabel.setStyle(.smallBlack)
    imageView.image = UIImage(named: "medal") ?? UIImage()
    titleLabel.text = "Achievement"
  }
}
