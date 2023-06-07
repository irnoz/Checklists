//
//  Checklist.swift
//  Checklists
//
//  Created by Irakli Nozadze on 07.06.23.
//

import Foundation

class Checklist: NSObject {
  var name: String
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
