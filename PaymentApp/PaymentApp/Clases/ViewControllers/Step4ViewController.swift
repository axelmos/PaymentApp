//
//  Step4ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class Step4ViewController: UIViewController {

    var installments = [Installment]()
    var mainView: Step4View! { return self.view as! Step4View }
    
    override func loadView() {
        view = Step4View(frame: UIScreen.main.bounds)
        mainView.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cuotas"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(Step1ViewController.nextStep))
        
        getInstallments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func nextStep () {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func getInstallments () {
        APIClient.sharedInstance.getInstallments(completionHandler: { [weak self] (installments, error)  in
            if self == nil {
                return
            }
            for item in installments ?? [] {
                do {
                    let installment = try Installment(dict:item)
                    self?.installments.append(installment)
                    
                } catch let error {
                    print("error parsing object: \(error)")
                }
            }
            
        }) { (error:String?) in
            
        }
    }
}

