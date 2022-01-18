//
//  Utils.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//
import UIKit
import Foundation

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

struct Mask {
    
    static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

extension String {
    func htmlAttributedString(size: CGFloat, color: UIColor) -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                color: \(color.hexString!);
                font-family: -apple-system;
                font-size: \(size)px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {

            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension UIView {
    /**
    Get Set x Position
    
    - parameter x: CGFloat
    */
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
    Get Set y Position
    
    - parameter y: CGFloat
    */
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
    Get Set Height
    
    - parameter height: CGFloat
    */
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
    Get Set Width
    
    - parameter width: CGFloat
    */
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
}

class MyTransformations {
   
     static func makeCardFromView(myViewR: UIView) -> UIView {
        
        let myView = myViewR
        
        myView.layer.cornerRadius = 10.0
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myView.layer.shadowRadius = 8.0
        myView.layer.shadowOpacity = 0.5
        
        return myView
    }

    
    
}

