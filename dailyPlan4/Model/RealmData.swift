//
//  RealmData.swift
//  dailyPlan4
//
//  Created by Рустем on 27.01.2024.
//

import Foundation
import RealmSwift

class TasksRealm: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var dateStart: String = ""
    @objc dynamic var dateFinish: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var taskDescription: String = ""
    
    convenience init(id: Int, dateStart: TimeInterval, dateFinish: TimeInterval, name: String, taskDescription: String) {
        self.init()
        self.id = id
        self.dateStart = String(dateStart)
        self.dateFinish = String(dateFinish)
        self.name = name
        self.taskDescription = taskDescription
    }
    
    
    
}
