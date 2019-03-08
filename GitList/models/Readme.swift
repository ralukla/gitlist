//
//  Readme.swift
//  GitList
//
//  Created by Raluca Radu on 08/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import Foundation

class Readme: NSObject {
    
    var url: String = ""
    
    init(_ theUrl: String = "") {
        url = theUrl
    }
    
    init(jsonData: [String: Any]) {
        url = jsonData["html_url"] as? String ?? ""
    }
    
    func isNil() -> Bool {
        if url != "" {
            return false
        }
        return true
    }
}
