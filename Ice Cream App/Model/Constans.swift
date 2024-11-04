//
//  Constans.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 02/11/24.
//

import UIKit

struct Constans {
    
    static let appName = "ICE CREAM APP"
    static let registerSegue = "registerToHome"
    static let loginSegue = "loginToHome"
    static let homeToEdit = "homeToEdit"
}

// MARK: - Ekstensi untuk reload data table dari AddViewController/EditViewController ke HomeViewController
extension Notification.Name {
    static let transactionDataChange = Notification.Name("transactionDataChange")
}
