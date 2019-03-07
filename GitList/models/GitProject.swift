//
//  GitProject.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class GitProject: NSObject {

    var name: String = ""
    var stars: Int = 0
    var desc: String = ""
    
    init(theName: String, theStars: Int, theDescription: String) {
        name = theName
        stars = theStars
        desc = theDescription
    }
    
    init(jsonData: [String: Any]) {
        
        name = ""
        if jsonData["full_name"] != nil {
            name = jsonData["full_name"] as! String
        }
        
        desc = ""
        if jsonData["description"] != nil {
            desc = jsonData["description"] as! String
        }
        
        stars = jsonData["watchers_count"] as! Int
    }
}
