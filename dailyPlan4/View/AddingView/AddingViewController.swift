//
//  AddingViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit

class AddingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    weak var delegate: ViewControllerDelegate?
    
    // MARK: - Private properties
    
    private var nameTask: String = String()
    
    private var startDateTask: Date = Date()
    
    private var finishDateTask: Date = Date()
    
    private var descriptionTask: String = String()
    
    // MARK: - Public properties
    
    @IBOutlet weak var nameTaskField: UITextField!
    
    @IBOutlet weak var startTaskPicker: UIDatePicker!
    
    @IBOutlet weak var finishTaskPicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTaskField: UITextView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        if let name = nameTaskField.text {
            nameTask = name
            if descriptionTaskField.text == nil {
                descriptionTask = ""
            } else {
                descriptionTask = descriptionTaskField.text
            }
            delegate?.addTask(nameTaskField.text!, startDate: startDateTask.currentTimestamp, finishDate: finishDateTask.currentTimestamp, descriptionTaskField.text!)
            self.dismiss(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - Public functions
    
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
