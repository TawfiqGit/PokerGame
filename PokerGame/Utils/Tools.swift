//
//  Tools.swift
//  PokerGame
//
//  Created by admin on 10/02/2023.
//

import Foundation

class Tools {
    
    static func toHexString(rgbRedValue : Int ,rgbGreenValue: Int , rgbBlueValue: Int) -> String{
        let hexValue =
            String(format:"%02X",Int(rgbRedValue)) +
            String(format:"%02X", Int(rgbGreenValue)) +
            String(format:"%02X",Int(rgbBlueValue))
        return hexValue
    }
    
}
