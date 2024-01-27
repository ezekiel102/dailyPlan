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
    
    init(id: Int, dateStart: TimeInterval, dateFinish: TimeInterval, name: String, description: String) {
        self.id = id
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.name = name
        self.description = description
    }
}
