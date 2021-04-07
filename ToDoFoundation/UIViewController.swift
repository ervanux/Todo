//
//  UIViewController.swift
//  ToDoFoundation
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import UIKit

public extension UIViewController {

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning".localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
