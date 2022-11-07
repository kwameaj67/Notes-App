//
//  UIButton+Ext.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 27/10/2022.
//

import Foundation
import UIKit

extension UIButton {
    func animatePulse(){
       UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
        self.transform = CGAffineTransform(scaleX: 0.93, y:0.93)
       } completion: { (_) in
           UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
           }, completion:nil)
       }
   }
}
