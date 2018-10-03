//
//  Step3View.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class Step3View: UIView {
    
    var infoLabel: UILabel!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.backgroundColor = UIColor.white
        
        infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.text = "Seleccione el banco con el que va a operar"
        infoLabel.textAlignment = .center
        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.greaterThanOrEqualTo(40)
        }
        
        tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel).offset(70)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
