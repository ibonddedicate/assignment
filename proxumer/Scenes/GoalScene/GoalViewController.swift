//
//  GoalViewController.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import UIKit

protocol GoalViewControllerDelegate {
  func createdNewGoal(goalInfo: GoalModel)
}

class GoalViewController: UIViewController {
  
  static public let viewName = "GoalView"
  static public let identifier = "GoalViewController"
  
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var goalTextField: UITextField!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var totalAmountTextField: UITextField!
  @IBOutlet weak var totalAmountCurrencyLabel: UILabel!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var dateChevronImage: UIImageView!
  @IBOutlet weak var currentAmountTextField: UITextField!
  @IBOutlet weak var currentAmountLabel: UILabel!
  @IBOutlet weak var currentAmountCurrencyLabel: UILabel!
  @IBOutlet weak var AddGoalButton: UIButton!
  private var viewModel: GoalViewModel? = nil
  public var delegate: GoalViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    collectionView.delegate   = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: GoalTypeCollectionViewCell.nibName, bundle: .main),
                            forCellWithReuseIdentifier: GoalTypeCollectionViewCell.identifier)
    topView.backgroundColor   = UIColor.proxumerYellow
    dateChevronImage.tintColor = UIColor.proxumerRed
    titleLabel.setStyle(.largeWhite)
    currentAmountLabel.setStyle(.mediumBlack)
    currentAmountCurrencyLabel.setStyle(.mediumRed)
    totalAmountCurrencyLabel.setStyle(.mediumRed)
    titleLabel.text = "What's your Goal?"
    currentAmountLabel.text = "Savings Amount"
    AddGoalButton.setTitle("Submit Goal", for: .normal)
    AddGoalButton.makeProxumerButton()
    AddGoalButton.isEnabled = false
    makeDatePicker()
    totalAmountTextField.keyboardType = .numberPad
    currentAmountTextField.keyboardType = .numberPad
    let textFields = [goalTextField,
                      totalAmountTextField,
                      dateTextField,
                      currentAmountTextField]
    for textField in textFields {
      textField?.font = UIFont.medium
      textField?.delegate = self
      textField?.layer.borderWidth = 1
      textField?.layer.borderColor = UIColor.proxumerRed.cgColor
    }
    navigationController?.isNavigationBarHidden = true
  }
  
  func config(viewModel: GoalViewModel) {
    self.viewModel = viewModel
  }
  
  @IBAction func addGoalTapped(_ sender: Any) {
    guard let goal = viewModel?.getSubmittedGoal() else { return }
    delegate?.createdNewGoal(goalInfo: goal)
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func dateChange(datePicker: UIDatePicker) {
    dateTextField.text = formatDate(date: datePicker.date)
    viewModel?.input.setDate(dateRemaining: datePicker.date)
    validation()
  }
  
  private func validation() {
    print(AddGoalButton.isEnabled)
    AddGoalButton.isEnabled = viewModel?.output.getValidation() ?? false
  }
}

extension GoalViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == goalTextField {
      viewModel?.input.setGoalName(name: textField.text ?? "")
    } else if textField == totalAmountTextField {
      viewModel?.input.setTotalAmount(amount: Int(textField.text ?? "") ?? 0)
    } else if textField == currentAmountTextField {
      viewModel?.input.setCurrentAmount(amount: Int(textField.text ?? "") ?? 0)
    }
    validation()
  }
  
  private func makeDatePicker() {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
    datePicker.frame.size = CGSize(width: 0, height: 300)
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.minimumDate = Date()
    dateTextField.inputView = datePicker
  }
  
  private func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMMM yyyy"
    return formatter.string(from: date)
  }
}

extension GoalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.output.getNumberOfRows() ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return viewModel?.output.getCell(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.input.setSelected(selected: indexPath.row)
    validation()
    collectionView.reloadData()
  }
}
