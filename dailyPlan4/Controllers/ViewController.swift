//
//  ViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, ViewControllerDelegate {

    // MARK: - Delegate properties and functions

    func addTask(_ name: String, startDate: TimeInterval, finishDate: TimeInterval, _ description: String) {
        viewModel.addToViewModel(name, startDate: startDate, finishDate: finishDate, description)
        updateData()
    }

    // MARK: - Private properties

    private let viewModel = ViewModel()

    private var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

    private let datePicker = UIDatePicker()

    private var tableView = UITableView()

    private var hours: [HourInterval] = Date().dayHours(from: Date())

    private var taskForDay: [Tasks]?

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
        updateData()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourCellView.self, forCellReuseIdentifier: String(describing: HourCellView.self))
        tableView.allowsSelection = false
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func makeLeftBarButtonItems() -> [UIBarButtonItem] {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.tintColor = .red
        let dateBarButtonItem = UIBarButtonItem(customView: datePicker)
        datePicker.addTarget(self, action: #selector(self.dateSet), for: .valueChanged)
        return [dateBarButtonItem]
    }

    func updateData() {
        taskForDay = viewModel.taskForDay(dayStart: hours[0].startHour,
                                          dayEnd: hours[23].endHour)
        self.tableView.reloadData()
    }

    @objc private func dateSet() {
        hours = Date().dayHours(from: datePicker.date)
        updateData()
    }

    @objc private func addButtonPressed() {
        let storyboard = UIStoryboard(name: "AddingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "AddingViewController"
        ) as? AddingViewController
        vc?.delegateViewController = self
        self.present(vc!, animated: true, completion: nil)
    }
}

// MARK: - Public methods

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = hours[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    String(describing: HourCellView.self),
                                                 for: indexPath) as! HourCellView
        if taskForDay == nil {
            cell.configure(data: item, number: indexPath.row, tasks: [])
        } else {
            let taskFiltered = filteredTasks(item, tasks: taskForDay!)
            cell.configure(data: item, number: indexPath.row, tasks: taskFiltered)
        }
        cell.delegate = self
        return cell
    }

    func filteredTasks(_ item: HourInterval, tasks: [Tasks]) -> [Tasks] {
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = hours[indexPath.row]
        let taskFiltered = filteredTasks(item, tasks: taskForDay!)
        if taskFiltered.count <= 1 {
            return 40
        } else {
            return CGFloat(40 + taskFiltered.count * 30 - 20)
        }
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
