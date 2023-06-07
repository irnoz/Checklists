//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Irakli Nozadze on 06.06.23.
//

import Foundation
import NotificationCenter

class ChecklistItem: NSObject, Codable {
  var text: String = ""
  var checked: Bool = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID = -1
  
  init(text: String, checked: Bool = false) {
    super.init()
    self.text = text
    self.checked = checked
    itemID = DataModel.nextChecklistItemID()
  }
  
  deinit {
    removeNotification()
  }
  
  // MARK: - Notifications
  func scheduleNotification() {
    removeNotification()
    if shouldRemind && dueDate > Date() {
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = text
      content.sound = UNNotificationSound.default
      
      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents(
        [.year, .month, .day, .hour, .minute],
        from: dueDate)
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: components,
        repeats: false)
      
      let request = UNNotificationRequest(
        identifier: "\(itemID)",
        content: content,
        trigger: trigger)
      
      let center = UNUserNotificationCenter.current()
      center.add(request)
//      print("Scheduled: \(request) for itemID: \(itemID)")
    }
  }
  
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    //  override init() {
    //    super.init()
    //    itemID = DataModel.nextChecklistItemID()
    //  }
    }
