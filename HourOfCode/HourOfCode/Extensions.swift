//
//  Extensions.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit
extension UIViewController {
    func showErrorAlert(errorMessage:String?) {
        
        let message = errorMessage ?? "Something went wrong"
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let okButtonTitle = "OK"
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(errorTitle: String?, errorMessage:String?) {
        let title = errorTitle ?? "Error"
        let message = errorMessage ?? "Something went wrong"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButtonTitle = "OK"
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentOkAlertWithTitle(_ title: String, message: String, okActionHandler: ((UIAlertAction) -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButtonTitle = "OK"
        let okAction: UIAlertAction = UIAlertAction(title: okButtonTitle, style: .default, handler: okActionHandler)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//Convert Dictionary into JSON
extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJSON() {
        print(json)
    }
}

extension Date {
    static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateString)
    }
}
