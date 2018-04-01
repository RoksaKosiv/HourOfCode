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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: dateString)
    }
    
    static func ifSameDate(date1: Date, date2: Date) -> Bool {
        let calendar = NSCalendar.current
        let startOfNow = calendar.startOfDay(for: date1)
        let startOfTimeStamp = calendar.startOfDay(for: date2)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        return (day == 0)
    }
    
    func toString(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

//MARK:- MBProgressHUD extension
import MBProgressHUD
extension MBProgressHUD {
    
    class func showProgressHud(view: UIView, animated: Bool) -> MBProgressHUD {
        let progressHUD = MBProgressHUD.showAdded(to:view, animated: true)
        progressHUD.mode = MBProgressHUDMode.indeterminate
        progressHUD.bezelView.color = UIColor.clear
        progressHUD.bezelView.style = .solidColor
        //progressHUD.bezelView.alpha = 0.8
        progressHUD.contentColor = UIColor.black
        progressHUD.removeFromSuperViewOnHide = true
        return progressHUD
    }
    
    class func showAnimated(onView view: UIView?) {
        if let view = view {
            let _ = MBProgressHUD.showProgressHud(view: view, animated: true)
        }
    }
    
    class func hideAnimated(forView view: UIView?) {
        if let view = view {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
