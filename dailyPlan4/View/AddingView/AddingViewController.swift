//
//  AddingViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit

class AddingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    private var nameTask: String = String()
    
    private var startDateTask: Date = Date()
    
    private var finishDateTask: Date = Date()
    
    private var descriptionTask: String = String()
    
    @IBOutlet weak var nameTaskField: UITextField!
    
    @IBOutlet weak var startTaskPicker: UIDatePicker!
    
    @IBOutlet weak var finishTaskPicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTaskField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTaskField.text = "Описание задачи"
        descriptionTaskField.delegate = self
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        if let name = nameTaskField.text {
            nameTask = name
            print(nameTask)
            print(startDateTask)
            print(finishDateTask)
            if descriptionTaskField.text == nil {
                descriptionTask = ""
            } else {
                descriptionTask = descriptionTaskField.text
            }
            print(descriptionTask)
            self.dismiss(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }

    @IBAction func didEndStartTask(_ sender: UIDatePicker) {
        startDateTask = startTaskPicker.date
    }
    
    @IBAction func didEndFinishTask(_ sender: UIDatePicker) {
        finishDateTask = finishTaskPicker.date
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTaskField.text == "Описание задачи" {
            descriptionTaskField.text = nil
        }
    }
    
}
