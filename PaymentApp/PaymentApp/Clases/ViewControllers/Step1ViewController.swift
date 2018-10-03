//
//  Step1ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class Step1ViewController: UIViewController {

    var paymentMethods = [PayMethod]()
    var mainView: Step1View! { return self.view as! Step1View }
    
    override func loadView() {
        view = Step1View(frame: UIScreen.main.bounds)
        mainView.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Monto"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(Step1ViewController.nextStep))
        
        getPaymentMethods()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func nextStep () {
        let vc = Step2ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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

