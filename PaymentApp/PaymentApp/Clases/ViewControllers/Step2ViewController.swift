//
//  Step2ViewController.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 03/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import UIKit
import SDWebImage

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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(Step1ViewController.nextStep))
        
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
    
    @objc func nextStep () {
        let vc = Step3ViewController()
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
            DispatchQueue.main.async {
                self?.mainView.tableView.reloadData()
            }
            
        }) { (error:String?) in
            
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
        cell.configureCell()
        cell.lblName.text = paymentMethods[indexPath.row].name
        
        /*if let url = URL.init(string: paymentMethods[indexPath.row].thumbnail ?? "") {
            cell.imgView.sd_setImage(with: url)
        }*/
        
        let imageURL = UIImage.gifImageWithURL(gifUrl: paymentMethods[indexPath.row].thumbnail ?? "")
        cell.imgView.image = imageURL
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
