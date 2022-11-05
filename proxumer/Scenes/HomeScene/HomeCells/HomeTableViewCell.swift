//
//  HomeTableViewCell.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import UIKit

protocol HomeTableViewCellDelegate {
  func tappedAddGoal()
}

class HomeTableViewCell: UITableViewCell {
  
  static public let nibName = "HomeTableViewCell"
  static public let identifier = "HomeTableViewCell"
  
  @IBOutlet weak var newGoalButton: UIButton!
  @IBOutlet weak var savingLabel: UILabel!
  @IBOutlet weak var goalLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var buttonBgView: UIView!
  public var delegate: HomeTableViewCellDelegate?
  var goalModels: [GoalModel?] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func setupUI() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: GoalCollectionViewCell.nibName, bundle: .main),
                            forCellWithReuseIdentifier: GoalCollectionViewCell.identifier)
    goalLabel.setStyle(.xLargeWhite)
    savingLabel.setStyle(.mediumWhite)
    buttonBgView.dropShadow(edge: .top, shadowSpace: 0)
    newGoalButton.setTitle("+ New Goal", for: .normal)
    newGoalButton.makeProxumerButton()
  }
  
  @IBAction func tappedNewGoal(_ sender: Any) {
    delegate?.tappedAddGoal()
  }
  
  public func config(data: [GoalModel?]) {
    goalModels = data
    goalLabel.text = "\(data.count) Goals"
    let totalSavings = data.map({$0?.currentAmount ?? 0}).reduce(0, +)
    let savingText = "All Savings \(totalSavings.addSeperator()) THB"
    savingLabel.text = savingText
    savingLabel.setSpannedFont(fullText: savingText,
                               changeText: String(totalSavings.addSeperator()),
                               font: UIFont.extraLarge)
    collectionView.reloadData()
  }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return goalModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCollectionViewCell.identifier, for: indexPath)
            as? GoalCollectionViewCell else { return UICollectionViewCell() }
    cell.config(data: goalModels[indexPath.row] ?? GoalModel())
    return cell
  }
  
  
}
