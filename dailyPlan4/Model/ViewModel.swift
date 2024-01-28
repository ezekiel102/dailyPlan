//
//  ViewMOdel.swift
//  dailyPlan4
//
//  Created by Рустем on 28.01.2024.
//
import UIKit
import RealmSwift

class ViewModel {
    let realm = try! Realm()
    private var taskArray: Results<TasksRealm>?
    private func getDataFromRealm(dayStart: TimeInterval, dayEnd: TimeInterval) {
        taskArray = realm.objects(TasksRealm.self).where {
            (($0.dateStart >= dayStart) && ($0.dateStart <= dayEnd)) ||
            (($0.dateFinish >= dayStart) && ($0.dateFinish <= dayEnd)) ||
            (($0.dateStart <= dayStart) && ($0.dateFinish >= dayEnd))
        }
    }

    private func addToRealm(data: TasksRealm) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error saving data \(error)")
        }
    }

    func taskForDay(dayStart: TimeInterval, dayEnd: TimeInterval) -> [Tasks] {
        getDataFromRealm(dayStart: dayStart, dayEnd: dayEnd)
        return taskArray!.map { Tasks(taskFromRealm: $0) }
    }

    func addToViewModel(_ name: String, startDate: TimeInterval, finishDate: TimeInterval, _ description: String) {
        let currentCount = realm.objects(TasksRealm.self).count
        let data = TasksRealm(id: currentCount,
                              dateStart: startDate,
                              dateFinish: finishDate,
                              name: name,
                              taskDescription: description)
        addToRealm(data: data)
    }

    init() {
        print("User Realm User file location: \(realm.configuration.fileURL!.path)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
