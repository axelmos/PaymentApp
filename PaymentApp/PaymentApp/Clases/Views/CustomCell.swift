//
//  CustomCell.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CustomCell: UITableViewCell {
    
    var lblName = UILabel()
    var imgView = UIImageView()
    
    func configureCell(name: String, thumbnail: String = "") {
        
        self.addSubview(lblName)
        
        if thumbnail != "" {
            self.addSubview(imgView)
            imgView.contentMode = .scaleAspectFit
            imgView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(20)
                make.width.equalTo(60)
                make.height.equalTo(40)
                make.centerY.equalToSuperview()
            }
            
            if let url = URL.init(string: thumbnail) {
                imgView.sd_setImage(with: url)
            }
        }
        
        lblName.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(thumbnail == "" ? 20 : 100)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        lblName.text = name
    }
}
