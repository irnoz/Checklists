//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Irakli Nozadze on 06.06.23.
//

import UIKit

class AddItemViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
  }
  
  // MARK: - Table View Delegates
  override func tableView(
    _ tableView: UITableView,
    willSelectRowAt indexPath: IndexPath
  ) -> IndexPath? {
    return nil
  }
  
  // MARK: Actions
  @IBAction func cancel() {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func done() {
    navigationController?.popViewController(animated: true)
  }
}
