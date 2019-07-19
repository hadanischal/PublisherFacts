//
//  RequestFactory.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

final class RequestFactory {
    enum Method: String {
        case GET,POST,PUT,DELETE,PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

