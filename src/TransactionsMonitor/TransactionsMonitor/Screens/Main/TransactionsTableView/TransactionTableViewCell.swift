//
//  TransactionCellTableViewCell.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    // MARK: - Views
    // MARK: Left Side
    let companyNameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let transactionDescriptionLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let bookingDateLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let leftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Right Side
    let amountLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let currencyLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let rightStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView() // call template
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Stacks Setups
    private func setupLeftStack() {
        leftStack.addArrangedSubview(companyNameLabel)
        leftStack.addArrangedSubview(transactionDescriptionLabel)
        leftStack.addArrangedSubview(bookingDateLabel)
    }
    
    private func setupRightStack() {
        rightStack.addArrangedSubview(amountLabel)
        rightStack.addArrangedSubview(currencyLabel)
    }
}

//MARK: - Template
extension TransactionTableViewCell: ViewCodeableTemplate {
    func buildViewHierarchy() {
        setupLeftStack()
        contentView.addSubview(leftStack)
        
        setupRightStack()
        contentView.addSubview(rightStack)
    }
    
    func setupConstraints() {
        
        leftStack.snp.makeConstraints { make in
            make.topMargin.bottomMargin.leadingMargin.equalToSuperview()
            make.right.equalTo(self.snp_centerXWithinMargins)
        }
        
        rightStack.snp.makeConstraints { make in
            make.topMargin.bottomMargin.trailingMargin.equalToSuperview()
            make.left.equalTo(self.snp_centerXWithinMargins)
        }
    }
}
