//
//  EOSProfileProtocol.swift
//  EOS
//
//  Created by Goutham Devaraju on 19/02/20.
//  Copyright © 2020 Goutham. All rights reserved.
//

import Foundation

protocol EOSProfilePresenterProtocol: class {
    
    //For fetching EOS profile data
    func fetchEOSProfile()
    
}

protocol EOSProfileViewProtocol: class {
    
    //For fetching EOS profile data
    func fetchEOSProfileAPI()
    
    
}
