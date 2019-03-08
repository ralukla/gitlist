//
//  DetailsViewModel.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject {

    var readme: Readme?
    
    func getReadme(gitProject: GitProject, completion: @escaping ((Readme) -> Void)) {
        
        guard gitProject.readme.isNil() else {
            completion(gitProject.readme)
            return
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchReadMe(owner: gitProject.owner.userName, repo: gitProject.name, completion: { (readme) in
            gitProject.linkReadme(readme!)
            completion(readme!)
        })
    }
}
