//
//  Step2ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SVProgressHUD

class Step2ViewController: UIViewController {

    var paymentMethods = [PayMethod]()
    var mainView: Step2View! { return self.view as! Step2View }
    
    override func loadView() {
        view = Step2View(frame: UIScreen.main.bounds)
        mainView.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Medio de pago"
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        getPaymentMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Payment.sharedInstance.step = .payMethod
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getPaymentMethods () {
        
        if !Utils.isInternetAvailable() {
            Utils.showAlert(message: "No se detectó una conexión a internet", context: self)
            return
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: "Loading")
        }
        
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

extension Step2ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.configureCell(name: paymentMethods[indexPath.row].name ?? "", thumbnail: paymentMethods[indexPath.row].thumbnail ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Payment.sharedInstance.paymentMethod = paymentMethods[indexPath.row]
        
        let vc = Step3ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
