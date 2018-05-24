//
//  ThemeColor.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

enum ThemeColor {
    static var primary:UIColor{
        return UIColor(red:0.122, green:0.737, blue:0.824, alpha:1.00)
    }
    
    static var primaryLight:UIColor{
        return UIColor(red: 163/255, green: 209/255, blue: 218/255, alpha: 1)
    }
    
    static var darkText:UIColor{
        return UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }
    
    static var text:UIColor{
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
    
    static var lightText:UIColor{
        return UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    }
    
    static var extraLightText:UIColor{
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    }
    
    
    
    static var separatorLine:UIColor{
        return UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    }
    
    static var lightSeparatorLine: UIColor{
        return UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    }
    
    static var brderSeparatorLine: UIColor{
        return UIColor(rgb: 0xdedede)
    }
    
    static var like:UIColor{
        return UIColor(red: 255/255, green: 0/255, blue: 114/255, alpha: 1)
    }
    
    static var white:UIColor{
        return UIColor.white
    }
    
    static var blue:UIColor{
        return UIColor(rgb: 0x0a52c6)
    }
    
    static var green:UIColor{
        return UIColor(rgb: 0x62d45a)
    }
    
    static var red:UIColor{
        return UIColor(rgb: 0xcf363c)
    }
    
    static var buttonBackgroundColor:UIColor{
        return UIColor(red:0.122, green:0.737, blue:0.824, alpha:1.00)
    }
    
    static var collectionViewBackgroundColor:UIColor{
        return UIColor(rgb:0xEAE8EA)
    }
    
    static var contentViewBackgroundColor:UIColor{
        return UIColor(rgb:0xEAE8EA)
    }
    
    static var viewBackgroundColor:UIColor{
        return UIColor(rgb:0xeef0f1)
    }
    
    static var placeholderColor:UIColor{
        return UIColor(rgb:0xeef0f1)
    }
    
    static var dimBlackColor:UIColor{
        return UIColor(rgb: 0x141414)
    }
}


enum ProjectsColor {
    static var active:UIColor{
        return UIColor(rgb: 0x2ebe68)
    }
    
    static var overdue:UIColor{
        return UIColor(rgb: 0xfd734f)
    }
    
    static var pending:UIColor{
        return UIColor(rgb: 0x1fbcd2)
    }
    
    static var running:UIColor{
        return UIColor(rgb: 0x2dbe67)
    }
    
    static var overdueWorkorder:UIColor{
        return UIColor(rgb: 0xfd734f)
    }
    
    
}


enum ProjectsOrderColor {
    static var blueColor:UIColor{
        return UIColor.blue
    }
    
    static var greenColor:UIColor{
        return UIColor.green
    }
    
    static var yellowColor:UIColor{
        return UIColor.yellow
    }
    
    static var redColor:UIColor{
        return UIColor.red
    }
    
    static var projectsNewColor:UIColor{
        return UIColor(rgb: 0x14e16d)
    }
    
    
    
}



struct  NavigationBar {
    //static let barTintColor = ThemeColor.primary
    
    static let barTintColor = ThemeColor.white
    static let TintColor = ThemeColor.darkText
    
    static let titleTextAttributes = [
        NSAttributedStringKey.foregroundColor:  ThemeColor.darkText ,
        NSAttributedStringKey.font :  UIFont.boldSystemFont(ofSize: 16)
    ]
    
}

/**********  textField Attribute Constant  *************/


enum textFieldAttributeConstant {
    
    struct  LOGINPAGE {
        static let TextFieldPlaceholderAttributes = [
            NSAttributedStringKey.foregroundColor:  UIColor.lightGray,
            NSAttributedStringKey.font :  UIFont.systemFont(ofSize: 16)
        ]
        
    }
    
    
    struct RegisterVCConstant {
        static let TextFieldPlaceholderAttributes = [
            NSAttributedStringKey.foregroundColor:  UIColor.lightGray,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)
        ]
        
    }
    
    
    
}

