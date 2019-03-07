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
    var fullName: String = ""
    var stars: Int = 0
    var desc: String = ""
    
    var owner: GitProjectOwner = GitProjectOwner()
    
    init(theName: String, theFullName: String, theStars: Int, theDescription: String, theOwner: GitProjectOwner) {
        name = theName
        fullName = theFullName
        stars = theStars
        desc = theDescription
        owner = theOwner
    }
    
    init(jsonData: [String: Any]) {
        
        name = ""
        if jsonData["name"] != nil {
            name = jsonData["name"] as! String
        }
        
        fullName = ""
        if jsonData["full_name"] != nil {
            fullName = jsonData["full_name"] as! String
        }
        
        desc = ""
        if jsonData["description"] != nil {
            desc = jsonData["description"] as! String
        }
        
        stars = jsonData["stargazers_count"] as! Int
        
        owner = GitProjectOwner(jsonData: jsonData["owner"] as! [String : Any])
    }
}
