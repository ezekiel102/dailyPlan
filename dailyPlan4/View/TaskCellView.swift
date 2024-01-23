//
// Cell.swift
//  dailyPlan4
//
//  Created by Рустем on 21.01.2024.
//

import UIKit
import Then


protocol TaskCellViewDelegate: AnyObject {
    func infoButtonPressed()
}

class TaskCellView: UITableViewCell, UITableViewDelegate {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(task: Tasks) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startH = formatter.string(from: Date(timeIntervalSince1970: task.dateStart))
        let endH = formatter.string(from: Date(timeIntervalSince1970: task.dateFinish))
        hours.text = "\(startH) - \(endH)"
        nameTask.text = "\(task.name)"
    }
    
    // MARK: - Private properties
    
    private let hours = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    private let nameTask = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
        $0.text = "coding"
    }
    
    // MARK: - Public properties

    var infoButton = UIButton(type: .detailDisclosure).then {
        $0.tintColor = .black
    }

    weak var delegate: TaskCellViewDelegate?
    
    
    @objc func infoButtonPressed() {
        delegate?.infoButtonPressed()
    }
    
}

// MARK: - Private methods

private extension TaskCellView {
    func initialize() {
        contentView.addSubview(hours)
        hours.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            
        }
        contentView.addSubview(nameTask)
        nameTask.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hours.snp.trailing).offset(10)
        }
        infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .allTouchEvents)
        contentView.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
