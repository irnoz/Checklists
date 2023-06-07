//
//  DataModel.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import Foundation

class DataModel {
  var lists = [Checklist]()
  var indexOfSelectedChecklist: Int {
    get {
      return UserDefaults.standard.integer(forKey: "ChecklistIndex")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
    }
  }
  
  init() {
//    simulateAllListItems()
//    simulateChecklistItems()
    loadChecklists()
    registerDefaults()
    handleFirstTime()
  }
  
  // MARK: - User Defaults
  func registerDefaults() {
    let dictionary = [
      "ChecklistIndex" : -1,
      "FirstTime": true
    ] as [String : Any]
    UserDefaults.standard.register(defaults: dictionary)
  }
  
  func handleFirstTime() {
    let userDefaults = UserDefaults.standard
    let firstTime = userDefaults.bool(forKey: "FirstTime")
    
    if firstTime {
      let checklist = Checklist(name: "List")
      lists.append(checklist)
      
      indexOfSelectedChecklist = 0
      userDefaults.set(false, forKey: "FirstTime")
    }
  }
  
  // MARK: - Data Saving
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask)
    return paths[0]
  }
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  func saveChecklists() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(lists)
      try data.write(
        to: dataFilePath(),
        options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding list array: \(error.localizedDescription)")
    }
  }
  
  func loadChecklists() {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        lists = try decoder.decode(
          [Checklist].self,
          from: data)
      } catch {
        print("Error decoding list array: \(error.localizedDescription)")
      }
    }
  }
  
  // MARK: - Simulating Test Data
  private func simulateAllListItems() {
    var list = Checklist(name: "Birthdays")
    lists.append(list)
    list = Checklist(name: "Groceries")
    lists.append(list)
    list = Checklist(name: "Cool Apps")
    lists.append(list)
    list = Checklist(name: "To Do")
    lists.append(list)
  }
  
  private func simulateChecklistItems() {
    // Add placeholder item data
    for list in lists {
      let item = ChecklistItem()
      item.text = "Item for \(list.name)"
      list.items.append(item)
    }
  }
}
