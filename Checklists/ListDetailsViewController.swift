//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import UIKit

protocol ListDetailsViewVontrollerDelegate: AnyObject {
  func listDetailsViewVontrollerDidCancel(
    _ controller: ListDetailsViewVontroller
  )
  func listDetailsViewVontroller(
    _ controller: ListDetailsViewVontroller,
    didFinishAdding checklist: Checklist
  )
  func listDetailsViewVontroller(
    _ controller: ListDetailsViewVontroller,
    didFinishEditing checklist: Checklist
  )
  
}


class ListDetailsViewVontroller: UITableViewController, UITextFieldDelegate {
  @IBOutlet var textField: UITextField!
  @IBOutlet var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailsViewVontrollerDelegate?
  
  var checklistToEdit: Checklist?
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
    if let checklist = checklistToEdit {
      title = checklist.name
      textField.text = checklist.name
      doneBarButton.isEnabled = true
    } else {
      title = "Add Checklist"
    }
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
    return nil
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
  
  // MARK: - Actions
  @IBAction func cancel() {
    delegate?.listDetailsViewVontrollerDidCancel(self)
  }
  @IBAction func done() {
    if let checklist = checklistToEdit {
      checklist.name = textField.text!
      delegate?.listDetailsViewVontroller(
        self,
        didFinishEditing: checklist)
    } else {
      let checklist = Checklist(name: textField.text!)
      delegate?.listDetailsViewVontroller(
        self,
        didFinishAdding: checklist)
    }
  }
}
