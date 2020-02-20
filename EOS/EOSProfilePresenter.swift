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
        
        let headers = [CONTENTTYPE : APPLICATION_JSON]
        
        let params = ["account_name" : "genialwombat"]
        
        _ = NetworkInterface.postRequest(.get_account, headers: headers as NSDictionary?, params: nil, payload: params, requestCompletionHander: {
            
            (success, data, response, error, header) -> (Void) in
            
            if success{
                
                do{
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AccountModel.self, from: data!)

                    //Passing back values to ViewController to make use of the data.
                    self.eos_profile_viewController?.accountData(account_data: response)
                }
                catch{
                    
                    print("Account model codable error: \(error)")
                }
            }
            else{
                //Handle API fetching failure case
                
            }
        })
    }
    
    
}
