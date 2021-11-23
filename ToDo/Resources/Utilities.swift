
import Foundation
import UIKit


class Utilities {
    
    static func Alert(Title: String,messageAlert: String) -> UIAlertController{
        let alert = UIAlertController(title: Title, message: messageAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
