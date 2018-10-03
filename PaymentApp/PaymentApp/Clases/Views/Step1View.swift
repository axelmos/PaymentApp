//
//  Step1View.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SnapKit

class Step1View: UIView {
    
    var infoLabel: UILabel!
    var amountField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        infoLabel = UILabel()
        amountField = UITextField()
        self.addSubview(infoLabel)
        self.addSubview(amountField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.backgroundColor = UIColor.white
        
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.text = "Ingrese el monto a pagar"
        infoLabel.textAlignment = .center
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.greaterThanOrEqualTo(40)
        }
        
        amountField.keyboardType = .decimalPad
        amountField.borderStyle = .roundedRect
        amountField.textAlignment = .center
        amountField.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel).offset(60)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
}
