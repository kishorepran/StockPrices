//
//  SPExtensions.swift
//  StocksPrice
//
//  Created by Pran Kishore on 30.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import UIKit

extension UIViewController {

typealias AlertComnpletion = ((UIAlertAction) -> Swift.Void)?

/**
 Show Error alert with a title and message. Does not have any thing in completion. Stays on the view controller that is being called.
 
 - Parameter error: Type of error that could be displayed to user.
 */
func showAlert(for error: SPError) {
    showErrorAlert(error.localizedTitle, message: error.localizedMessage)
}
/**
 Show Error alert with a title and message. Does not have any thing in completion. Stays on the view controller that is being called.
 
 - Parameter title: Title of the alert. Defaults to "Stock Quotes"
 - Parameter message: Message to be displayed to user
 */
func showErrorAlert(_ title: String?, message: String) {

    let text: String = title ?? "Stock Quotes"
    let alertController = UIAlertController(title: text, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_ : UIAlertAction) -> Void in

    }

    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
}
}
