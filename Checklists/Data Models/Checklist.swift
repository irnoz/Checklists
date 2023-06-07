//
//  Checklist.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import Foundation

class Checklist: NSObject, Codable {
  var name: String
  var items = [ChecklistItem]()
  var iconName = "No Icon"
  
  init(name: String, iconName: String = "No Icon") {
    self.name = name
    self.iconName = iconName
    super.init()
  }
  
  func countUncheckedItems() -> Int {
//    var count = 0
//    for item in items where !item.checked {
//      count += 1
//    }
//    return count
    // functional language version below
    return items.reduce(0) { cnt, item in
      cnt + (item.checked ? 0 : 1) 
    }
  }
}
