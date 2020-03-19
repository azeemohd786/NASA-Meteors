//
//  UIView+Extensions.swift
//  Athletics Central
//
//  Created by JMATICS 3 on 19/02/20.
//  Copyright © 2020 J'Ouvertmatics. All rights reserved.
//

import Foundation
import UIKit


extension UIView
{
    func showOrHideViewWithAnimation(hidden: Bool) {
           UIView.transition(with: self, duration: 0.5, options: .transitionCurlDown, animations: {
               self.isHidden = hidden
           })
       }
    func showToast(toastMessage:String,duration:CGFloat)
       {
           //View to blur bg and stopping user interaction
           let bgView = UIView(frame: self.frame)
           bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))
           bgView.tag = 555
           
           //Label For showing toast text
           let lblMessage = UILabel()
           lblMessage.numberOfLines = 0
           lblMessage.lineBreakMode = .byWordWrapping
           lblMessage.textColor = .white
           lblMessage.backgroundColor = UIColor(red: 208/255.0, green: 1/255.0, blue: 27/255.0, alpha: 1)
           lblMessage.textAlignment = .center
           lblMessage.font = UIFont.init(name: "Roboto-Regular", size: 17)
           lblMessage.text = toastMessage
           
           //calculating toast label frame as per message content
           let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
           var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
           // UILabel can return a size larger than the max size when the number of lines is 1
           expectedSizeTitle = CGSize(width:maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width), height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
           lblMessage.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width+16)/2) , y: (self.bounds.size.height/2) - ((expectedSizeTitle.height+16)/2), width: expectedSizeTitle.width+16, height: expectedSizeTitle.height+16)
           lblMessage.layer.cornerRadius = 8
           lblMessage.layer.masksToBounds = true
           bgView.addSubview(lblMessage)
           self.addSubview(bgView)
           lblMessage.alpha = 0
           
           UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
               lblMessage.alpha = 1
           }, completion: {
               sucess in
               UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
                   lblMessage.alpha = 0
                   bgView.alpha = 0
               })
               bgView.removeFromSuperview()
           })
       }
}
extension CGFloat
{
    func getminimum(value2:CGFloat)->CGFloat
    {
        if self < value2
        {
            return self
        }
        else
        {
            return value2
        }
    }
}
