//
//  CustomCell.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    var lblName = UILabel()
    var imgView = UIImageView()
    
    func configureCell() {
        self.addSubview(imgView)
        self.addSubview(lblName)
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        lblName.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}
