//
//  Protocols.swift
//  dailyPlan4
//
//  Created by Рустем on 23.01.2024.
//

import Foundation


protocol TaskCellViewDelegate: AnyObject {
    func infoButtonPressed(infoTask: Tasks)
}

protocol HourCellViewDelegate: AnyObject {
    func infoButtonPressed(infoTask: Tasks)
}

protocol ViewControllerDelegate: AnyObject {
    func infoButtonPressed(infoTask: Tasks)
    func addTask(_ name: String, startDate: TimeInterval, finishDate: TimeInterval, _ description: String)
}

