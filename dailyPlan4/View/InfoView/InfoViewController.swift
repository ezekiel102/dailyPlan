//
//  InfoViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 22.01.2024.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var nameTaskLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var finishDateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var numb = 2
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numb = 3
        
    }
    
}
