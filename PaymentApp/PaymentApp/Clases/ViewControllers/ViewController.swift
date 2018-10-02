//
//  ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var paymentMethods = [PayMethod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPaymentMethods()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getPaymentMethods () {
        APIClient.sharedInstance.getPaymentMethods(completionHandler: { [weak self] (payMethods, error)  in
            if self == nil {
                return
            }
            for item in payMethods ?? [] {
                do {
                    let payment = try PayMethod(dict:item)
                    self?.paymentMethods.append(payment)
                    
                } catch let error {
                    print("error parsing object: \(error)")
                }
            }
            
        }) { (error:String?) in
            
        }
    }
}

