//
//  TransactionTableViewFooter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class TransactionTableViewFooter: UIView {
    
    // MARK: Views
    
    private let summationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let backgroudEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView() // call ViewCodeableTemplate
        setSummation(0)
    }
    
    func setSummation(_ value: Int) {
        summationLabel.text = "Summation = \(value)"
    }
}

// MARK: Custom View Template
extension TransactionTableViewFooter: ViewCodeableTemplate {
    func buildViewHierarchy() {
        self.addSubview(backgroudEffect)
        self.addSubview(summationLabel)
    }
    
    func setupConstraints() {
        
        backgroudEffect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        summationLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
