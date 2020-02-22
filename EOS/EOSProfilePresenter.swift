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
    
    //Fetching EOS Account data
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
    
    func formula(){
        
        //
        //RAM: 1142836 ÷ 2217255 = 0.51542831113246 = 51.542831113246%
        //https://medium.com/if-let-swift-programming/how-to-create-a-stretchable-tableviewheader-in-ios-ee9ed049aba3
        
    }
    
    
}
