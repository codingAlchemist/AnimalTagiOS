//
//  VisualConstraintHelper.swift
//  xmlLayoutTest
//
//  Created by jason debottis on 7/13/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

public class VisualConstraintHelper: NSObject {
    
    public static func makeConstraintWith(_ parent: UIView, children: Dictionary<String,UIView>, constraint: String){
        for view in children.values{
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        parent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: children))
    }
}
