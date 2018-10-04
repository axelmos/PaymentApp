//
//  Step4ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        getInstallments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Payment.sharedInstance.step = .installment
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getInstallments () {
        
        if !Utils.isInternetAvailable() {
            Utils.showAlert(message: "No se detectó una conexión a internet", context: self)
            return
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: "Loading")
        }
        APIClient.sharedInstance.getInstallments(completionHandler: { [weak self] (installments, error)  in
            if self == nil {
                return
            }
            if let payerCosts = installments![0]["payer_costs"] as? [[String:AnyObject]] {
                for item in payerCosts {
                    do {
                        let installment = try Installment(dict:item)
                        self?.installments.append(installment)
                        
                    } catch let error {
                        print("error parsing object: \(error)")
                    }
                }
            }
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self?.mainView.tableView.reloadData()
            }
            
        }) { (error:String?) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
    }
}

// MARK: - UITableViewDataSource
// ----------------------------------------------------

extension Step4ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.configureCell(name: installments[indexPath.row].message ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Payment.sharedInstance.installments = installments[indexPath.row]
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
