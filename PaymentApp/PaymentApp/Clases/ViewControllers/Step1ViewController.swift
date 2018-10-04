//
//  Step1ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class Step1ViewController: UIViewController {

    var mainView: Step1View! { return self.view as! Step1View }
    
    override func loadView() {
        view = Step1View(frame: UIScreen.main.bounds)
        mainView.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Monto"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(Step1ViewController.nextStep))
        self.hideKeyboardWhenTappedScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Payment.sharedInstance.step = .amount
        
        if Payment.sharedInstance.installments != nil {
            DispatchQueue.main.async {
                Utils.showAlert(message: "El monto a pagar es de $ \(Payment.sharedInstance.amount ?? "")\n Medio de pago: \(Payment.sharedInstance.paymentMethod?.name ?? "")\n Banco: \(Payment.sharedInstance.bank?.name ?? "")\n Cuotas: \(Payment.sharedInstance.installments?.message ?? "0")\n", context: self)
                
                self.mainView.amountField.text = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func nextStep () {
        
        if mainView.amountField.text == "" {
            Utils.showAlert(message: "Ingrese un monto a pagar", context: self)
        } else {
            Payment.sharedInstance.amount = mainView.amountField.text
            let vc = Step2ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
