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
    
    weak var delegate2: ViewControllerDelegate?

    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

    func configure(data: HourInterval, number: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startH = formatter.string(from: Date(timeIntervalSince1970: data.startHour))
        let endH = formatter.string(from: Date(timeIntervalSince1970: data.endHour + 1))
        hour.text = "\(startH) - \(endH)"
    }
    
    // MARK: - Private properties

    private let hour = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }

    
    private var items = ViewController().tasks
    
    private var colour = UIColor.clear
 
    var tableView = UITableView(frame: .zero)
    
}
// MARK: - Private methods

private extension HourCellView {
    func initialize() {
        print("hourcellview init")
        print(ViewController().tasks)
        contentView.backgroundColor = colour
        contentView.addSubview(hour)
        hour.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview().offset(10)
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
        print(2)
        delegate?.infoButtonPressed()
        
    }
}
