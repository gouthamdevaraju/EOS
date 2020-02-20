//
//  EOSProfileViewController.swift
//  EOS
//
//  Created by Goutham Devaraju on 19/02/20.
//  Copyright © 2020 Goutham. All rights reserved.
//

import UIKit

class EOSProfileViewController: UIViewController {

    //MARK: - Properties
    var eosProfilePresenter : EOSProfilePresenter?
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialising presenter objects
        self.eosProfilePresenter = EOSProfilePresenter(view: self)
        
        //Fetching profile data initially
        fetchEOSProfileAPI()
    }

}

extension EOSProfileViewController: EOSProfileViewProtocol{
    
    //Initiate fetch EOS profile
    func fetchEOSProfileAPI() {
        
        //Fetching EOS account data
        eosProfilePresenter?.fetchEOSProfile()
    }
    
    //Got the account data. Plot the UI.
    func accountData(account_data: AccountModel) {
        
        if let account_name = account_data.account_name{
            print("Account name: \(account_name)")
        }
        else{
            print("Account name not found")
        }
    }
    
    
}
