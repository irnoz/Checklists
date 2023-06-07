//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Irakli Nozadze on 06.06.23.
//

import Foundation

class ChecklistItem: NSObject, Codable {
  var text: String = ""
  var checked: Bool = false
  
  init(text: String, checked: Bool = false) {
    self.text = text
    self.checked = checked
  }
}
