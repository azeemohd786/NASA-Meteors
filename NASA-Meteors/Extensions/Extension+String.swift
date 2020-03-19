//
//  Extension+String.swift
//  Athletics Central
//
//  Created by JMATICS 3 on 20/02/20.
//  Copyright © 2020 J'Ouvertmatics. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
extension String {
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self)?.doubleValue
    }
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
           guard let range = self.range(of: needle) else { return nil }
           if beforeNeedle {
               return self.substring(to: range.lowerBound)
           }
          return self.substring(from: range.upperBound)
    }
  
        func chopPrefix(_ count: Int = 1) -> String {
               if count >= 0 && count <= self.count {
                   let indexStartOfText = self.index(self.startIndex, offsetBy: count)
                   return String(self[indexStartOfText...])
               }
               return ""
           }

           func chopSuffix(_ count: Int = 1) -> String {
               if count >= 0 && count <= self.count {
                   let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
                   return String(self[..<indexEndOfText])
               }
               return ""
           }

   
  
}

extension UITableViewController
{
    class alert {
        func msgNS(message: String, title: String = "")
        {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }
}

