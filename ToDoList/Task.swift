//
//  Task.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 26.07.2022.
//

import Foundation

struct Task {
    var title: String
    var isComplete: Bool
    
    init(title: String, isComplete: Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
}
