//
//  infoView.swift
//  dailyPlan4
//
//  Created by Рустем on 25.01.2024.
//

import UIKit

class InfoView: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    var task: Tasks? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.DD HH:mm"
            nameLabel.text = task?.name
            startDateLabel.text = formatter.string(from: Date(timeIntervalSince1970: task!.dateStart))
            finishDateLabel.text = formatter.string(from: Date(timeIntervalSince1970: task!.dateFinish))
            descriptionLabel.text = task?.description
        }
    }
    
    // MARK: - Private constants
    
    private enum UIConstants {
        static let topInset: CGFloat = 30
        static let leadingInset: CGFloat = 5
        static let trailingInset: CGFloat = 5
        static let bottomInset: CGFloat = 30
        static let height: CGFloat = 30
        static let fontSize: CGFloat = 17
    }
    
    // MARK: - Private properties

    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIConstants.fontSize)
        $0.textAlignment = .left
    }
    
    private let startDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIConstants.fontSize)
        $0.textAlignment = .left
    }
    
    private let finishDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIConstants.fontSize)
        $0.textAlignment = .left
    }
    
    private let descriptionLabel = UITextView().then {
        $0.font = .systemFont(ofSize: UIConstants.fontSize)
        $0.textAlignment = .left
        $0.backgroundColor = .clear
    }
}

// MARK: - Private methods

private extension InfoView {
    func initialize() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(nameLabel)
        view.addSubview(startDateLabel)
        view.addSubview(finishDateLabel)
        view.addSubview(descriptionLabel)
                
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.topInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.topInset)
            make.height.equalTo(UIConstants.height)
        }
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.topInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.topInset)
            make.height.equalTo(UIConstants.height)
        }
        finishDateLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(UIConstants.topInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.topInset)
            make.height.equalTo(UIConstants.height)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(finishDateLabel.snp.bottom).offset(UIConstants.topInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.topInset)
            make.bottom.equalToSuperview().inset(UIConstants.bottomInset)
        }
    }
}
