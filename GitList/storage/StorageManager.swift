//
//  StorageManager.swift
//  GitList
//
//  Created by Raluca Radu on 07/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class StorageManager: NSObject {

    struct Projects
    {
        struct Response
        {
            var projectsArray: [GitProject]
            
            init(projects: [GitProject] = []) {
                self.projectsArray = projects
            }
        }
    }
}
