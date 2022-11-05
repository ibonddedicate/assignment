//
//  AchievementViewController.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import UIKit

class AchievementViewController: UIViewController {
  
  static public let viewName = "AchievementView"
  static public let identifier = "AchievementViewController"
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var titleImage: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    headerView.backgroundColor = UIColor.proxumerYellow
    titleImage.image = UIImage(named:"achievementTab")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    titleImage.tintColor = .white
    titleLabel.setStyle(.largeWhite)
    descriptionLabel.setStyle(.xLargeWhite)
    titleLabel.text = "Achievement"
    descriptionLabel.text = "Level 2"
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: AchievementCollectionViewCell.nibName, bundle: .main),
                            forCellWithReuseIdentifier: AchievementCollectionViewCell.identifier)
  }
}

extension AchievementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementCollectionViewCell.identifier, for: indexPath)
            as? AchievementCollectionViewCell else { return UICollectionViewCell() }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width-80)/3
    return CGSize(width: width, height: width)
  }
}
