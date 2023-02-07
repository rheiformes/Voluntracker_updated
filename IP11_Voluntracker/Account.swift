//
//  Account.swift
//  IP11_Voluntracker
//
//  Created by Rai, Rhea on 1/18/23.
//

import Foundation

class Account: Codable {
    var username: String = ""
    var password: String = ""
    
    var goalHours: Double = 0.0
    var completedHours: Double = 0.0
    
    init(username: String, password: String, goalHours: Double, completedHours: Double) {
        self.username = username
        self.password = password
        self.goalHours = goalHours
        self.completedHours = completedHours
    }
    
}
