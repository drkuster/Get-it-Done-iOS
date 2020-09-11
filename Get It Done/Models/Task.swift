//
//  Task.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/10/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

class Task {
    
    var description: String
    var category: String
    
    init(_ description: String, _ category: String) {
        self.category = category
        self.description = description
    }
}
