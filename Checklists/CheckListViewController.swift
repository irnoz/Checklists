//
//  ViewController.swift
//  Checklists
//
//  Created by Irakli Nozadze on 06.06.23.
//

import UIKit

class CheckListViewController: UITableViewController {
  var items = [ChecklistItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let item1 = ChecklistItem()
    item1.text = "Walk the dog"
    items.append(item1)
    let item2 = ChecklistItem()
    item2.text = "Brush my teeth"
    item2.checked = true
    items.append(item2)
    let item3 = ChecklistItem()
    item3.text = "Learn iOS development"
    item3.checked = true
    items.append(item3)
    let item4 = ChecklistItem()
    item4.text = "Soccer practice"
    items.append(item4)
    let item5 = ChecklistItem()
    item5.text = "Eat ice cream"
    items.append(item5)
  }
  
  //  MARK: TableVIew Data Source
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return items.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem",
      for: indexPath)
    
    let item = items[indexPath.row]
    let label = cell.viewWithTag(1000) as! UILabel

    label.text = item.text
    configureCheckmark(for: cell, at: indexPath)
    return cell
  }
  
  //  MARK: TableView Delegate
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.checked.toggle()
      configureCheckmark(for: cell, at: indexPath)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func configureCheckmark(
    for cell: UITableViewCell,
    at indexPath: IndexPath
  ) {
    let item = items[indexPath.row]
    if item.checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
}
