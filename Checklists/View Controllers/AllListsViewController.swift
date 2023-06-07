//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailsViewVontrollerDelegate, UINavigationControllerDelegate {
  var dataModel: DataModel!
  let cellIdentifier = "ChecklistCell"
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
  
  // important ! p:439
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    navigationController?.delegate = self
    
    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.lists.count {
      let checkList = dataModel.lists[index]
      performSegue(
        withIdentifier: "ShowChecklist",
        sender: checkList)
    }
  }
  
  // MARK: - Table view data source
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return dataModel.lists.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath)
    let checklist = dataModel.lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    dataModel.lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // MARK: - Table View Delegate
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    dataModel.indexOfSelectedChecklist = indexPath.row
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  override func tableView(
    _ tableView: UITableView,
    accessoryButtonTappedForRowWith indexPath: IndexPath
  ) {
    let controller = storyboard?.instantiateViewController(
      withIdentifier: "ListDetailViewController") as! ListDetailsViewVontroller
    controller.delegate = self
    
    let checklist = dataModel.lists[indexPath.row]
    controller.checklistToEdit = checklist
    
    navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: - List Details View Controller Deligates
  func listDetailsViewVontrollerDidCancel(
    _ controller: ListDetailsViewVontroller) {
      navigationController?.popViewController(animated: true)
    }
  
  func listDetailsViewVontroller(
    _ controller: ListDetailsViewVontroller,
    didFinishAdding checklist: Checklist
  ) {
    let newRowIndex = dataModel.lists.count
    dataModel.lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailsViewVontroller(
    _ controller: ListDetailsViewVontroller,
    didFinishEditing checklist: Checklist
  ) {
    if let index = dataModel.lists.firstIndex(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Navigation Controller Delegates
  func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool
  ) {
    // if back button was tapped
    if viewController === self {
      dataModel.indexOfSelectedChecklist = -1
    }
  }
  
  // MARK: - Navigation
  override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?
  ) {
    if segue.identifier == "ShowChecklist" {
      let controller = segue.destination as! CheckListViewController
      controller.checklist = sender as? Checklist
    } else if segue.identifier == "AddChecklist" {
      let controller = segue.destination as! ListDetailsViewVontroller
      controller.delegate = self
    }
  }
}
