//
//  ViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, ViewControllerDelegate {
    
    func addTask(_ name: String, startDate: TimeInterval, finishDate: TimeInterval, _ description: String) {
        let task = Tasks(id: tasks.count + 1, dateStart: startDate, dateFinish: finishDate, name: name, description: description)
        tasks.append(task)
        print(tasks)
        self.tableView.reloadData()
    }
    
    var tasks: [Tasks] = [Tasks(id: 1, dateStart: 1706313700.0, dateFinish: 1706316199.0, name: "name", description: "description")]
     
    weak var delegate: ViewControllerDelegate?
    
    // MARK: - Private properties
    
    private var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    private let datePicker = UIDatePicker()
    
    private var tableView = UITableView()
    
    private var items: [HourInterval] = Date().dayHours(from: Date())
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private methods

private extension ViewController {
    func initialize() {
        navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
        navigationItem.setRightBarButtonItems([addBarButton], animated: true)
        addBarButton.target = self
        addBarButton.action = #selector(addButtonPressed)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourCellView.self, forCellReuseIdentifier: String(describing: HourCellView.self))
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.rowHeight = 100
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
        items = Date().dayHours(from: datePicker.date)
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HourCellView.self), for: indexPath) as! HourCellView
        cell.configure(data: item, number: indexPath.row, tasks: filterTasks(item, tasks: tasks))
        cell.delegate = self
        return cell
    }
    
    func filterTasks(_ item: HourInterval, tasks: [Tasks]) -> [Tasks] {
        var tasksFiltered: [Tasks] = []
        for task in tasks {
            if task.dateStart >= item.startHour && task.dateStart <= item.endHour ||
                task.dateFinish >= item.startHour && task.dateFinish <= item.endHour ||
                task.dateStart <= item.startHour && task.dateFinish >= item.endHour {
                tasksFiltered.append(task)
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
