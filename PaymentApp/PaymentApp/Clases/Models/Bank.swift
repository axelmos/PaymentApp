//
//  Bank.swift
//  PaymentApp
//
//  Created by Axel Mosiejko on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import Foundation

struct Bank {
    var id: String?
    var name: String?
    var thumbnail: String?
    
    init(dict: Dictionary<String, AnyObject>) throws  {
        
        if let _id = dict["id"] as? String {
            id = _id
        }
        
        if let _name = dict["name"] as? String {
            name = _name
        }
        
        if let _thumbnail = dict["secure_thumbnail"] as? String {
            thumbnail = _thumbnail
        }
    }
}
