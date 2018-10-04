//
//  APIClient.swift
//  PaymentApp
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 01/10/2018.
//  Copyright © 2018 Mosiejko Axel (Producto Y Tecnologia). All rights reserved.
//

import Foundation
import Alamofire

typealias ArrayDictionaryErrorResponse = ([[String: AnyObject]]?, Error?) -> Void
typealias DictionaryErrorResponse = ([String: AnyObject]?, Error?) -> Void
typealias StringResponse = (String?) -> Void

class APIClient: NSObject {
    
    static let sharedInstance = APIClient()
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    private let baseURL = "https://api.mercadopago.com/v1/payment_methods"
    private let token = "444a9ef5-8a6b-429f-abdf-587639155d88"
    
    // MARK: GET PAYMENT METHODS (CREDIT CARDS, DEBIT CARDS, ETC)
    
    func getPaymentMethods( completionHandler:@escaping ArrayDictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        let request = baseURL + "?public_key=\(token)"
            
        doRequest(request: request, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    // MARK: GET CARD ISSUERS (BANKS)
    
    func getCardIssuers(completionHandler:@escaping ArrayDictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        var payMethodId = "0"
        if let paymentMethod = Payment.sharedInstance.paymentMethod {
            payMethodId = paymentMethod.id ?? ""
        }
        
        let request = baseURL + "/card_issuers?public_key=\(token)&payment_method_id=\(payMethodId)"
        
        doRequest(request: request, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    // MARK: GET INSTALLMENTS
    
    func getInstallments(completionHandler:@escaping ArrayDictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        let amount = Payment.sharedInstance.amount ?? "0"
        var payMethodId = "0"
        var bankId = "0"
        
        if let paymentMethod = Payment.sharedInstance.paymentMethod {
            payMethodId = paymentMethod.id ?? ""
        }
        if let bank = Payment.sharedInstance.bank {
            bankId = bank.id ?? ""
        }
        
        let request = baseURL + "/installments?public_key=\(token)&amount=\(amount)&payment_method_id=\(payMethodId)&issuer.id=\(bankId)"
        
        doRequest(request: request, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func doRequest (request: String, completionHandler:@escaping ArrayDictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        Alamofire.request(request, method: .get)
            .responseJSON {  [weak self ] response in
                if let dataOK = response.data {
                    do {
                        guard let dictionary = try JSONSerialization.jsonObject(with: dataOK, options: .mutableContainers) as? [[String: AnyObject]] else {
                            errorHandler("An error occurrred parsing the response.")
                            return
                        }
                        completionHandler(dictionary, response.result.error)
                        
                    } catch {
                        errorHandler("An error occurrred parsing the response.")
                    }
                }
                else{
                    errorHandler(self?.getMessageError(response: response.response, data: nil))
                }
        }
    }
    
    // -----------------------------
    
    func getMessageError(response: URLResponse?, data:Data?) -> String {
        
        guard let _ = response else {
            return("Check your internet connection")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return("Invalid data")
        }
        
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            return("Invalid Response: \(statusCode)")
        }
        
        guard data != nil else {
            return("Error obtaining data")
        }
        
        return "Unexpected error"
    }
}
