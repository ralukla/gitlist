//
//  ListViewModel.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {

    var array: [GitProject]?
    var defaultList: [GitProject]?
    
    func getArray(completion: @escaping (() -> Void)) {
        
        if array != nil && array!.count != 0 {
            return
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchTrendingList { (projects) in
            self.array = projects
            self.defaultList = self.array
            completion()
        }
    }
    
    func fullList() {
        array = defaultList
    }
    
    func search(searchText: String) {
        
        array?.removeAll()
        
        for project in defaultList! {
            if project.name.lowercased().contains(searchText.lowercased()) || project.fullName.lowercased().contains(searchText.lowercased()) || project.desc.lowercased().contains(searchText.lowercased()) {
                array?.append(project)
            }
        }
    }
}
