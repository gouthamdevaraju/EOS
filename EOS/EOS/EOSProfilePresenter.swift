//
//  EOSProfilePresenter.swift
//  EOS
//
//  Created by Goutham Devaraju on 19/02/20.
//  Copyright © 2020 Goutham. All rights reserved.
//

import Foundation

class EOSProfilePresenter: EOSProfilePresenterProtocol{
    
    //MARK: - Properties
    var eos_profile_viewController : EOSProfileViewController? = nil
    
    //MARK: - Methods
    required init(view: EOSProfileViewController) {
        self.eos_profile_viewController = view
    }
    
    func fetchEOSProfile() {
        
        //Fetch profile
    }
    
    
}
