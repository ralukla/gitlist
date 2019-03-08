//
//  DetailsViewModel.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject {

    var owner: GitProjectOwner?
    var readme: Readme?
    
    func getOwner(gitProject: GitProject, completion: @escaping ((GitProjectOwner) -> Void)) {
        
        guard gitProject.owner.isNil() else {
            completion(gitProject.owner)
            return
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchOwner(gitProject: gitProject, completion: { (owner) in
            gitProject.linkOwner(owner!)
            completion(owner!)
        })
    }
    
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
