//
//  TableCellDesignView.swift
//  MyPlaces
//
//  Created by user145617 on 11/18/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class TableCellDesignView : UIView {
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
        
        
    }
}
