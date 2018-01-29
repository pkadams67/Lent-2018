//  See LICENSE folder for this project’s licensing information.

import UIKit

struct ErrorHandling {
    
    static let ErrorOKButton       = "Got it!"
    static let ErrorDefaultMessage = "Please try again"
    
    static func defaultErrorHandler(_ error: NSError?, title: String) {
        let alert  = UIAlertController(title: title, message: ErrorDefaultMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ErrorOKButton, style: UIAlertActionStyle.default, handler: nil))
        let window = UIApplication.shared.windows[0]
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func presentAlert(_ title: String, message: String){
        let alert  = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ErrorOKButton, style: UIAlertActionStyle.default, handler: nil))
        let window = UIApplication.shared.windows[0]
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
