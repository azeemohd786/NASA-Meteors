//
//  Storyboard+Extensions.swift
//  Athletics Central
//
//  Created by JMATICS 3 on 19/02/20.
//  Copyright © 2020 J'Ouvertmatics. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension UIStoryboard
{
    // MARK: Storyboard Methods
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    class func onboardStoryboard() -> UIStoryboard {
          return UIStoryboard(name: "OnBoardStoryboard", bundle: nil)
      }
      
    
    class func MainVC() -> MainVC?
    {
        return mainStoryboard().instantiateViewController(withIdentifier: "MainVC") as? MainVC
    }

    
   
    
}
