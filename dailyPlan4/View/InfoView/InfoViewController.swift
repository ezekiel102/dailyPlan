//
//  InfoViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 22.01.2024.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Public properties

    
    // MARK: - Public properties

    @IBOutlet weak var nameTaskLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var finishDateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var task1 = Tasks(id: 1, dateStart: 1705937101, dateFinish: 1705938452, name: "privet", description: "smotri suda")
    
    var task: Tasks? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.DD HH:mm"
            nameTaskLabel.text = task?.name
            startDateLabel.text = formatter.string(from: Date(timeIntervalSince1970: task!.dateStart))
            finishDateLabel.text = formatter.string(from: Date(timeIntervalSince1970: task!.dateFinish))
            descriptionLabel.text = task?.description
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        task = Tasks(id: 2, dateStart: 1705937101, dateFinish: 1705938452, name: "poka", description: "smotri suda")
    }
    
}
