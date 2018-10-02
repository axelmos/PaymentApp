//
//  Installment.swift
//  PaymentApp
//
//  Created by Axel Mosiejko on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import Foundation

struct Installment {
    var installments: Int?
    var installmentAmount: Int?
    var totalAmount: Int?
    var message: String?
    
    init(dict: Dictionary<String, AnyObject>) throws  {
        
        if let _installments = dict["installments"] as? Int {
            installments = _installments
        }
        
        if let _installmentAmount = dict["installment_amount"] as? Int {
            installmentAmount = _installmentAmount
        }
        
        if let _totalAmount = dict["total_amount"] as? Int {
            totalAmount = _totalAmount
        }
        
        if let _message = dict["recommended_message"] as? String {
            message = _message
        }
    }
}
