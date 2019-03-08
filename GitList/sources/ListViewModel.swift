//
//  ListViewModel.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {

    var projectsList: [GitProject]?
    var defaultProjectList: [GitProject]?
    var lastSince: Int = -1
    
    func getProjectList(since: Int, completion: @escaping (() -> Void)) {
        
        guard since != lastSince else {
            return
        }
        
        lastSince = since
        let networkManager = NetworkManager()
        networkManager.fetchTrendingList(since: since) { (projects) in
            self.projectsList = projects
            self.defaultProjectList = self.projectsList
            completion()
        }
    }
    
    func getDefaultProjectList() {
        projectsList = defaultProjectList
    }
    
    func search(searchText: String) {
        
        projectsList?.removeAll()
        
        for project in defaultProjectList! {
            if project.name.lowercased().contains(searchText.lowercased()) || project.fullName.lowercased().contains(searchText.lowercased()) || project.desc.lowercased().contains(searchText.lowercased()) {
                projectsList?.append(project)
            }
        }
    }
}
