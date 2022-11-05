//
//  BannerCollectionViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
  
  static public let nibName = "BannerCollectionViewCell"
  static public let identifier = "BannerCollectionViewCell"
  
  @IBOutlet weak var bannerImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
  }
  
  private func setupUI() {
    setCornerRadius()
  }
  
  public func config(image: UIImage) {
    bannerImage.image = image
  }
  
}
