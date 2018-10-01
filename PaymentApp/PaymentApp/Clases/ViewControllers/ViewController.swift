//
//  ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        APIClient.sharedInstance.getPaymentMethods(completionHandler: { [weak self] (projects, error)  in
            if self == nil {
                return
            }
            
        }) { (error:String?) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

