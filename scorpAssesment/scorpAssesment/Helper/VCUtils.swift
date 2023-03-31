//
//  VCUtils.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation
import UIKit

class VCUtils {
    
   static func showAlertAction(title: String, message: String, viewController: UIViewController,alertButtonTitle: String = "Yeniden dene",action: @escaping()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: alertButtonTitle, style:   UIAlertAction.Style.default, handler: { (alert) in
            action()
        }))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
        
       
    }
    
    
}
