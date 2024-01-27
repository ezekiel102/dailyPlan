//
//  ViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then
import SnapKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, ViewControllerDelegate {
    
    //MARK: - RealmData
    
    let realm = try! Realm()
    
    private var taskArray: Results<TasksRealm>?
    
    private func getDataFromRealm() {
        taskArray = realm.objects(TasksRealm.self).sorted(byKeyPath: "id", ascending: true)
        print("privet realm")
        self.tableView.reloadData()
    }
    
    private func addToRealm(data: TasksRealm) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error saving data \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Delegate properties and functions
    
    func addTask(_ name: String, startDate: TimeInterval, finishDate: TimeInterval, _ description: String) {
        if taskArray == nil {
            addToRealm(data: TasksRealm(id: 0,
                                        dateStart: startDate,
                                        dateFinish: finishDate,
                                        name: name,
                                        taskDescription: description
                                       ))
        } else {
            addToRealm(data: TasksRealm(id: taskArray![taskArray!.count - 1].id + 1,
                                        dateStart: startDate,
                                        dateFinish: finishDate,
                                        name: name,
                                        taskDescription: description
                                       ))
        }
        self.tableView.reloadData()
    }
    
//    var tasks: [Tasks] = [Tasks(id: 1, dateStart: 1706313700.0, dateFinish: 1706316199.0, name: "name", description: "description")]
     
//    weak var delegate: ViewControllerDelegate?
    
    // MARK: - Private properties
    
    private var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    private let datePicker = UIDatePicker()
    
    private var tableView = UITableView()
    
    private var hours: [HourInterval] = Date().dayHours(from: Date())
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private methods

private extension ViewController {
    func initialize() {
        print("init start")
        getDataFromRealm()
        navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
        navigationItem.setRightBarButtonItems([addBarButton], animated: true)
        addBarButton.target = self
        addBarButton.action = #selector(addButtonPressed)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourCellView.self, forCellReuseIdentifier: String(describing: HourCellView.self))
        tableView.allowsSelection = false
        tableView.rowHeight = 80
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        print("User Realm User file location: \(realm.configuration.fileURL!.path)")
    }
    
    func makeLeftBarButtonItems() -> [UIBarButtonItem] {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
        let dateBarButtonItem = UIBarButtonItem(customView: datePicker)
        datePicker.addTarget(self, action: #selector(self.dateSet), for: .valueChanged)
        return [dateBarButtonItem]
    }
    
    @objc private func dateSet() {
        hours = Date().dayHours(from: datePicker.date)
        tableView.reloadData()
    }
    
    @objc private func addButtonPressed() {
        let storyboard = UIStoryboard(name: "AddingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddingViewController") as? AddingViewController
        vc?.delegate = self
        self.present(vc!, animated: true , completion: nil)
    }
}

// MARK: - Public methods

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = hours[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourCellView.self), for: indexPath) as! HourCellView
        if taskArray == nil {
            cell.configure(data: item, number: indexPath.row, tasks: [])
        } else {
            let taskFiltered = filteredTasks(item, tasks: taskArray!)
            cell.configure(data: item, number: indexPath.row, tasks: taskFiltered)
        }
        cell.delegate = self
        return cell
    }
    
    func filteredTasks(_ item: HourInterval, tasks: Results<TasksRealm>) -> [Tasks] {
        var tasksFiltered: [Tasks] = []
        for task in tasks {
            if TimeInterval(task.dateStart)! >= item.startHour && TimeInterval(task.dateStart)! <= item.endHour ||
                TimeInterval(task.dateFinish)! >= item.startHour && TimeInterval(task.dateFinish)! <= item.endHour ||
                TimeInterval(task.dateStart)! <= item.startHour && TimeInterval(task.dateFinish)! >= item.endHour {
                tasksFiltered.append(Tasks(id: task.id,
                                           dateStart: TimeInterval(task.dateStart)!,
                                           dateFinish: TimeInterval(task.dateFinish)!,
                                           name: task.name,
                                           description: task.taskDescription
                                          ))
            }
        }
        return tasksFiltered
    }
}

extension ViewController: TaskCellViewDelegate {
    func infoButtonPressed(infoTask: Tasks) {
        let vc = InfoView()
        vc.delegate = self
        vc.task = infoTask
        self.present(vc, animated: true)
        print(3)
    }
}

