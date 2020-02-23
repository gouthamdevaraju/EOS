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
    
    func processAccountDataAndPassToViews(account_data: AccountModel)
}

protocol EOSProfileViewProtocol: class {
    
    //For fetching EOS profile data
    func fetchEOSProfileAPI()
    
    func setNavigationTitle(stringAccountName: String)
    
    func setEOSBalance(stringEOSBalance: String)
    
    func setStakedValue(stringStakedValues: String)
    
    //Setting net details
    func setNetStake(stringNetValue: String, stringNetUsed: String, stringNetTotal: String, percentage: Int)
    
    //Setting CPU details
    func setCPUStake(stringCPUValue: String, stringCPUUsed: String, stringCPUTotal: String, percentage: Int)
    
    //Setting RAM details
    func setRAMUsed(stringRAMUsed: String, stringRAMTotal: String, percentage: Int)
    
    //Setting converted dollar value
    func setConvertedDollarValue(stringDollarValue: String)
}
