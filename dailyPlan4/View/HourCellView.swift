//
// Cell.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then

protocol HourCellViewDelegate: AnyObject {
    func infoButtonPressed()
}

class HourCellView: UITableViewCell, UITableViewDelegate {
    
    weak var delegate: TaskCellViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var items: [Tasks] = [
        Tasks(id: 1, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 1", description: "opisanie 1"),
        Tasks(id: 2, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 2", description: "opisanie 2"),
        Tasks(id: 3, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 3", description: "opisanie 3"),
        Tasks(id: 4, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 4", description: "opisanie 4"),
        Tasks(id: 5, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 5", description: "opisanie 5"),
        Tasks(id: 6, dateStart: 1705937101, dateFinish: 1705938452, name: "zadacha 6", description: "opisanie 6")
    ]
    
    
    func configure(data: HourInterval, number: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startH = formatter.string(from: Date(timeIntervalSince1970: data.startHour))
        let endH = formatter.string(from: Date(timeIntervalSince1970: data.endHour + 1))
        hour.text = "\(startH) - \(endH)"
        numberLabel.text = "\(number)"
        
    }
    
    // MARK: - Private properties

    private let hour = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    private let numberLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }

    private var colour = UIColor.clear
 
    private var tableView = UITableView(frame: .zero)
    
}
// MARK: - Private methods

private extension HourCellView {
    func initialize() {
        print("hourcellview init")
        contentView.backgroundColor = colour
        contentView.addSubview(hour)
        hour.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview().offset(10)
        }
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalTo(hour.snp.trailing).offset(10)
        }
        contentView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCellView.self, forCellReuseIdentifier: String(describing: TaskCellView.self))
        tableView.snp.makeConstraints { make in
            make.top.equalTo(hour.snp.bottom)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.leading.equalTo(hour.snp.trailing)
            
        }
        tableView.rowHeight = 40
    }
    @objc func infoButtonPressed2() {
//        let storyboard = UIStoryboard(name: "InfoViewController", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "InfoViewController")
//        vc.task = Tasks(id: 1, dateStart: 1705937101, dateFinish: 1705938452, name: "privet", description: "smotri suda")
//        self.navigationController.present(vc, animated: true , completion: nil)
        print(2)
    }
}

// MARK: - Public methods

extension HourCellView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCellView.self), for: indexPath) as! TaskCellView
        cell.configure(task: item)
        cell.delegate = self
        return cell
    }
}

extension HourCellView: TaskCellViewDelegate {
    func infoButtonPressed() {
        delegate?.infoButtonPressed()
    }
}
