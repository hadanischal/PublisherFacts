//
//  AppTarget.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/25/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

private extension String{
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum AppTarget {
    case login(username:String, password:String)
}

extension AppTarget{
    var baseURL: URL {return URL(string: "http://dev.com")!}
    var path: String {
        switch self {
        case .login:
            return "/token"
        }
    }
}
