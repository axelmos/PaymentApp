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
    private let key = "444a9ef5-8a6b-429f-abdf-587639155d88​"
    
    func getPaymentMethods( completionHandler:@escaping ArrayDictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        /*
        let url = NSURL(string: baseURL + "?public_key=\(key)")!
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        */
        
        Alamofire.request(baseURL + "?public_key=\(key)", method: .get)
        //Alamofire.request(request)
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
