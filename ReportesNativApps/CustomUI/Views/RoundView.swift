//
//  RoundView.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//

import Foundation
import UIKit

@IBDesignable class RoundView: UIView {
    
    @IBInspectable var radius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyMask()
    }
    
    func applyMask()
    {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
