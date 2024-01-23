//
//  Protocols.swift
//  dailyPlan4
//
//  Created by Рустем on 23.01.2024.
//

import Foundation


protocol TaskCellViewDelegate: AnyObject {
    func infoButtonPressed()
}

protocol HourCellViewDelegate: AnyObject {
    func infoButtonPressed()
}

protocol ViewControllerDelegate: AnyObject {
    func infoButtonPressed()
    
}
