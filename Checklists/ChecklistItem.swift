//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Irakli Nozadze on 06.06.23.
//

import Foundation

class ChecklistItem: Equatable {
  static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
    lhs.text == rhs.text
  }
  
  var text: String = ""
  var checked: Bool = false
  
}
