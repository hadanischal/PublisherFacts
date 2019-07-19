//
//  ThemeColor.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

enum ThemeColor {
    static var primary: UIColor{
        return UIColor(red:0.122, green:0.737, blue:0.824, alpha:1.00)
    }
    
    static var primaryLight: UIColor{
        return UIColor(red: 163/255, green: 209/255, blue: 218/255, alpha: 1)
    }
    
    static var darkText: UIColor{
        return UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }
    
    static var text: UIColor{
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
    
    static var lightText: UIColor{
        return UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    }
    
    static var extraLightText: UIColor{
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }
       
    static var white: UIColor{
        return UIColor.white
    }
    
    static var blue: UIColor{
        return UIColor(rgb: 0x0a52c6)
    }
    
    static var green: UIColor{
        return UIColor(rgb: 0x62d45a)
    }
    
    static var red: UIColor{
        return UIColor(rgb: 0xcf363c)
    }
    
    static var buttonBackgroundColor: UIColor{
        return UIColor(red:0.122, green:0.737, blue:0.824, alpha:1.00)
    }
    
    static var collectionViewBackgroundColor: UIColor{
        return UIColor(rgb:0xEAE8EA)
    }
    
    static var contentViewBackgroundColor: UIColor{
        return UIColor(rgb:0xEAE8EA)
    }
    
    static var viewBackgroundColor: UIColor{
        return UIColor(rgb:0xeef0f1)
    }
    
    static var placeholderColor:UIColor{
        return UIColor(rgb:0xeef0f1)
    }
    
    static var dimBlackColor: UIColor{
        return UIColor(rgb: 0x141414)
    }
}
