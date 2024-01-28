//
// Cell.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then

class HourCellView: UITableViewCell, UITableViewDelegate {

    weak var delegate: TaskCellViewDelegate?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(data: HourInterval, number: Int, tasks: [Tasks]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startH = formatter.string(from: Date(timeIntervalSince1970: data.startHour))
        let endH = formatter.string(from: Date(timeIntervalSince1970: data.endHour + 1))
        hour.text = "\(startH) - \(endH)"
        itemsTask = tasks
    }

    // MARK: - Private properties

    private let hour = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }

    private var itemsTask: [Tasks] = []

    private var colour = UIColor.clear

    var tableView = UITableView(frame: .zero)

}
// MARK: - Private methods

private extension HourCellView {
    func initialize() {
        tableView.register(TaskCellView.self, forCellReuseIdentifier: String(describing: TaskCellView.self))
        contentView.backgroundColor = colour
        contentView.addSubview(hour)
        contentView.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorColor = .clear
        tableView.allowsSelection = false

        tableView.rowHeight = 30
        hour.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview().offset(15)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.leading.equalTo(hour.snp.trailing)
        }
    }
    @objc func infoButtonPressed2() {
        print(2)
    }
}

// MARK: - Public methods

extension HourCellView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsTask.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsTask[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    String(describing: TaskCellView.self),
                                                 for: indexPath) as! TaskCellView
        cell.configure(taskFrom: item)
        cell.delegate = self
        return cell
    }

}

extension HourCellView: TaskCellViewDelegate {
    func infoButtonPressed(infoTask: Tasks) {
        print(2)
        delegate?.infoButtonPressed(infoTask: infoTask)
    }
}
