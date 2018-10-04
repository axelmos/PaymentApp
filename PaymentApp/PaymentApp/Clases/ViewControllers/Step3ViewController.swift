//
//  Step3ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        getBanks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Payment.sharedInstance.step = .bank
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getBanks () {
        
        if !Utils.isInternetAvailable() {
            Utils.showAlert(message: "No se detectó una conexión a internet", context: self)
            return
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: "Loading")
        }
        APIClient.sharedInstance.getCardIssuers(completionHandler: { [weak self] (banks, error)  in
            if self == nil {
                return
            }
            let _banks = banks ?? []
            for item in _banks {
                do {
                    let bank = try Bank(dict:item)
                    self?.banks.append(bank)
                    
                } catch let error {
                    print("error parsing object: \(error)")
                }
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if _banks.count == 0 {
                    Utils.showAlert(message: "No se encontraron entidades bancarias asociadas al medio de pago \(Payment.sharedInstance.paymentMethod?.name ?? "")", context: self!)
                } else {
                    self?.mainView.tableView.reloadData()
                }
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

extension Step3ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.configureCell(name: banks[indexPath.row].name ?? "", thumbnail: banks[indexPath.row].thumbnail ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Payment.sharedInstance.bank = banks[indexPath.row]
        
        let vc = Step4ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
