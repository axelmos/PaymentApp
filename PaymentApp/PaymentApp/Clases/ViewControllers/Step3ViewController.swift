//
//  Step3ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit

class Step3ViewController: UIViewController {

    var banks = [Bank]()
    var mainView: Step3View! { return self.view as! Step3View }
    
    override func loadView() {
        view = Step3View(frame: UIScreen.main.bounds)
        mainView.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Banco"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(Step1ViewController.nextStep))
        
        getBanks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func nextStep () {
        let vc = Step4ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func getBanks () {
        APIClient.sharedInstance.getCardIssuers(completionHandler: { [weak self] (banks, error)  in
            if self == nil {
                return
            }
            for item in banks ?? [] {
                do {
                    let bank = try Bank(dict:item)
                    self?.banks.append(bank)
                    
                } catch let error {
                    print("error parsing object: \(error)")
                }
            }
            
        }) { (error:String?) in
            
        }
    }
}

