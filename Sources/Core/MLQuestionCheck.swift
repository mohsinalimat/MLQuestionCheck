//
//  MLQuestionCheck.swift
//  MLQuestionCheck
//
//  Created by Michel Anderson Lutz Teixeira on 02/10/17.
//  Copyright © 2017 micheltlutz. All rights reserved.
//

import UIKit

open class MLQuestionCheck: UIView {
    static let name = "MLQuestionCheck"
    private var checkButton = MLQuestionCheckButton()
    open let labelQuestion: UILabel = {
        let labelQuestion = UILabel(frame: .zero)
        labelQuestion.translatesAutoresizingMaskIntoConstraints = false
        labelQuestion.text = ""
        labelQuestion.textColor = UIColor(hex: "333333")
        return labelQuestion
    }()
    private var isChecked = false
    open var question: String!
    open var didChangeState: ((_ isChecked: Bool) -> Void)?
    open var uncheckedImageName: String?
    open var checkedImageName: String?
    convenience public init(question: String, checked: Bool? = false) {
        self.init(frame: .zero)
        self.question = question
        self.isChecked = checked!
        labelQuestion.text = self.question
        setupCheck()
        setupButtonActions()
        setupViewConfiguration()
    }
    open func setupCheck() {
        if let uncheckedImageName = uncheckedImageName {
            checkButton.uncheckedImageName = uncheckedImageName
        }
        
        if let checkedImageName = checkedImageName {
            checkButton.checkedImageName = checkedImageName
        }
    }
    private func setupButtonActions() {
        checkButton.didCheck = { [weak self] in
            self?.isChecked = true
            self?.checkButton.viewState = .checked
            self?.didChangeState?(true)
        }
        checkButton.didUnChack = { [weak self] in
            self?.isChecked = false
            self?.checkButton.viewState = .unChecked
            self?.didChangeState?(false)
        }
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension MLQuestionCheck: ViewConfiguration {
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 36).isActive = true
        checkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelQuestion.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 16).isActive = true
        labelQuestion.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        labelQuestion.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor).isActive = true
    }
    
    func buildViewHierarchy() {
        addSubview(checkButton)
        addSubview(labelQuestion)
    }
    
    func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
