//
//  Contants.swift
//  AnimalTagiOS
//
//  Created by jason debottis on 7/29/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

public class Constants: NSObject {
    
    //public static let fa_list = Character(UnicodeScalar(UInt32(hexString:"f039")!))
    public static let fa_list = "\u{f082}"
    public static let localUrl = "http://localhost:8080/"
    public static let baseUrl = "http://jason-debottis.com/"
    
    
}
extension UInt32{
    init?(hexString: String) {
        let scanner = Scanner(string: hexString)
        var hexInt = UInt32.min
        let success = scanner.scanHexInt32(&hexInt)
        if success {
            self = hexInt
        } else {
            return nil
        }
    }
}
