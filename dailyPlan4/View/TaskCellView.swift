//
// Cell.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then

class TaskCellView: UITableViewCell, UITableViewDelegate {

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(taskFrom: Tasks) {
        task = taskFrom
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startH = formatter.string(from: Date(timeIntervalSince1970: taskFrom.dateStart))
        let endH = formatter.string(from: Date(timeIntervalSince1970: taskFrom.dateFinish))
        hours.text = "\(startH) - \(endH)"
        nameTask.text = "\(taskFrom.name)"
    }

    // MARK: - Private properties

    private let hours = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }

    private let nameTask = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }

    private var task: Tasks?

    // MARK: - Public properties

    var infoButton = UIButton(type: .detailDisclosure).then {
        $0.tintColor = .red
    }

    weak var delegate: TaskCellViewDelegate?

    @objc func infoButtonPressed() {
        delegate?.infoButtonPressed(infoTask: task!)
    }

}

// MARK: - Private methods

private extension TaskCellView {
    func initialize() {
        contentView.addSubview(hours)
        contentView.addSubview(nameTask)
        contentView.addSubview(infoButton)

        infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .allTouchEvents)

        infoButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        nameTask.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hours.snp.trailing).offset(10)
        }
        hours.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
    }
}
