//
//  Data.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import Foundation

struct Tasks: Codable {
    let id: Int
    let dateStart: TimeInterval
    let dateFinish: TimeInterval
    let name: String
    let description: String
    
    init(taskFromRealm: TasksRealm) {
        self.id = taskFromRealm.id
        self.dateStart = taskFromRealm.dateStart
        self.dateFinish = taskFromRealm.dateFinish
        self.name = taskFromRealm.name
        self.description = taskFromRealm.taskDescription
    }
}
