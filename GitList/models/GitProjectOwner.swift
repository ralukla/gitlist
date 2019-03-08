//
//  GitProjectOwner.swift
//  GitList
//
//  Created by Raluca Radu on 07/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class GitProjectOwner: NSObject {

    var userName: String = ""
    var avatarUrl: String = ""
    
    init(_ theUserName: String = "", _ theAvatarUrl: String = "") {
        userName = theUserName
        avatarUrl = theAvatarUrl
    }

    init(jsonData: [String: Any]) {
        userName = jsonData["login"] as? String ?? ""
        avatarUrl = jsonData["avatar_url"] as? String ?? ""
    }
    
    func isNil() -> Bool {
        return userName != "" ? false : true
    }
}
