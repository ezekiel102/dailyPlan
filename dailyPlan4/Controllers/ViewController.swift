//
//  ViewController.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then
import SnapKit

private var dateToday = Date()

class ViewController: UIViewController, UITableViewDelegate, ViewControllerDelegate {
    
    weak var delegate: ViewControllerDelegate?
    
    var numb: Int = 0
    
    // MARK: - Private properties
    
    private var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    private let datePicker = UIDatePicker()
    
    private var tableView = UITableView()
    
    private var items: [HourInterval] = Date().dayHours(from: dateToday)
    
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
        tableView.rowHeight = 150
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
        dateToday = datePicker.date
    }
    
    @objc private func addButtonPressed() {
        let storyboard = UIStoryboard(name: "AddingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddingViewController")
        self.present(vc, animated: true , completion: nil)
    }
    
    func taskDelegate() -> Tasks {
        return Tasks(id: 2, dateStart: 1705937101, dateFinish: 1705938452, name: "name", description: "description")
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
        cell.configure(data: item, number: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension ViewController: TaskCellViewDelegate {
    func infoButtonPressed() {
        let vc = InfoView()
        vc.delegate = self
        vc.task = Tasks(id: 2, dateStart: 1705937101, dateFinish: 1705938452, name: "name", description: "description")
        self.present(vc, animated: true)
        print(3)
    }
}
