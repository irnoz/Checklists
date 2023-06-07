//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import UIKit

protocol ListDetailsViewControllerDelegate: AnyObject {
  func listDetailsViewControllerDidCancel(
    _ controller: ListDetailsViewController
  )
  func listDetailsViewController(
    _ controller: ListDetailsViewController,
    didFinishAdding checklist: Checklist
  )
  func listDetailsViewController(
    _ controller: ListDetailsViewController,
    didFinishEditing checklist: Checklist
  )
  
}


class ListDetailsViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
  @IBOutlet var textField: UITextField!
  @IBOutlet var doneBarButton: UIBarButtonItem!
  @IBOutlet var iconImage: UIImageView!
  
  weak var delegate: ListDetailsViewControllerDelegate?
  
  var checklistToEdit: Checklist?
  var iconName = "Folder"
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
    if let checklist = checklistToEdit {
      title = checklist.name
      textField.text = checklist.name
      doneBarButton.isEnabled = true
      iconName = checklist.iconName
    }
    iconImage.image = UIImage(named: iconName)
//    else {
//      title = "Add Checklist"
//    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  // MARK: - Table View Delegate
  override func tableView(
    _ tableView: UITableView,
    willSelectRowAt indexPath: IndexPath
  ) -> IndexPath? {
    return indexPath.section == 1 ? indexPath : nil
  }
  
  // MARK: - Text Field Delegates
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    
    doneBarButton.isEnabled = !newText.isEmpty
    return true
  }
  
  func textFieldShouldClear(
    _ textField: UITextField
  ) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
  
  // MARK: - Icon Picker View Controller Delegate
  func iconPicker(
    _ picker: IconPickerViewController,
    didPick iconName: String
  ) {
    self.iconName = iconName
    iconImage.image = UIImage(named: iconName)
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Navigation
  override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?
  ) {
    if segue.identifier == "PickIcon" {
      let controller = segue.destination as! IconPickerViewController
      controller.delegate = self
    }
  }
  
  // MARK: - Actions
  @IBAction func cancel() {
    delegate?.listDetailsViewControllerDidCancel(self)
  }
  @IBAction func done() {
    if let checklist = checklistToEdit {
      checklist.name = textField.text!
      checklist.iconName = iconName
      delegate?.listDetailsViewController(
        self,
        didFinishEditing: checklist)
    } else {
      let checklist = Checklist(name: textField.text!, iconName:iconName)
      delegate?.listDetailsViewController(
        self,
        didFinishAdding: checklist)
    }
  }
}
