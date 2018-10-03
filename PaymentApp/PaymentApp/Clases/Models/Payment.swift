//
//  Payment.swift
//  PaymentApp
//
//  Created by Axel Mosiejko on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import Foundation

struct Payment {
    
    static var sharedInstance = Payment()
    var amount: String?
    var paymentMethod: PayMethod?
    var bank: Bank?
    var installments: Installment?
    var step: Step?
}
