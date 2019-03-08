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
    var forks: Int = 0
    var desc: String = ""
    
    var owner: GitProjectOwner = GitProjectOwner()
    var readme: Readme = Readme()
    
    init(theName: String, theFullName: String, theStars: Int, theForks: Int, theDescription: String, theOwner: GitProjectOwner, theReadme: Readme) {
        name = theName
        fullName = theFullName
        stars = theStars
        forks = theForks
        desc = theDescription
        owner = theOwner
        readme = theReadme
    }
    
    init(jsonData: [String: Any]) {
        name = jsonData["name"] as? String ?? ""
        fullName = jsonData["full_name"] as? String ?? ""
        desc = jsonData["description"] as? String ?? ""
        stars = jsonData["stargazers_count"] as? Int ?? 0
        forks = jsonData["forks_count"] as? Int ?? 0
        
        owner = GitProjectOwner(jsonData: jsonData["owner"] as! [String : Any])
    }
    
    func linkReadme(_ theReadme: Readme) {
        readme = theReadme
    }
}
