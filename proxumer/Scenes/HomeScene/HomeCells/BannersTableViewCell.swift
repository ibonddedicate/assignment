//
//  BannersTableViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

class BannersTableViewCell: UITableViewCell {
  
  static public let nibName = "BannersTableViewCell"
  static public let identifier = "BannersTableViewCell"
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var banners: [UIImage] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setupUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  private func setupUI() {
    titleLabel.setStyle(.largeBlack)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: BannerCollectionViewCell.nibName, bundle: .main),
                            forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
  }
  
  public func config(title: String, data: [UIImage]) {
    banners = data
    titleLabel.text = title
    collectionView.reloadData()
  }
}

extension BannersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return banners.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
    cell.config(image: banners[indexPath.row])
    return cell
  }
  
  
}
