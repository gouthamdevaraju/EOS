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
    
    //Hardcoded dollar value
    static let dollarValue: Float = {
        return 4.2801
    }()
    
    //MARK: - Methods
    required init(view: EOSProfileViewController) {
        self.eos_profile_viewController = view
    }
    
    //MARK: - Fetching EOS Account data
    func fetchEOSProfile() {
        
        //Fetch profile
        
        let headers = [CONTENTTYPE : APPLICATION_JSON]
        
        let params = ["account_name" : "genialwombat"]
        
        _ = NetworkInterface.postRequest(.get_account, headers: headers as NSDictionary?, params: nil, payload: params, requestCompletionHander: {
            
            (success, data, response, error, header) -> (Void) in
            
            if success{
                
                do
                {
                    let decoder = JSONDecoder()
                    let accountData = try decoder.decode(AccountModel.self, from: data!)
                    self.processAccountDataAndPassToViews(account_data: accountData)
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
    
    //MARK: - Process Account Data
    func processAccountDataAndPassToViews(account_data: AccountModel){
        
        if let account_name = account_data.account_name{
            DispatchQueue.main.async {
                self.eos_profile_viewController?.setNavigationTitle(stringAccountName: account_name)
            }
        }
        
        if let account_EOS_balance = account_data.core_liquid_balance{
            DispatchQueue.main.async {
                self.eos_profile_viewController?.setEOSBalance(stringEOSBalance: account_EOS_balance)
            }
            
            let eleminated_eos_string = account_EOS_balance.replacingOccurrences(of: " EOS", with: "")
            
            if let eos_float_value = Float(eleminated_eos_string){
                let converted_val = eos_float_value*EOSProfilePresenter.dollarValue
                self.eos_profile_viewController?.setConvertedDollarValue(stringDollarValue: String(format: "= %.2f $", converted_val))
            }
            
        }
        
        if let voterInfo = account_data.voter_info{
            if let staked_value = voterInfo.staked{
                DispatchQueue.main.async {
                    self.eos_profile_viewController?.setStakedValue(stringStakedValues: "\(staked_value)")
                }
            }
        }
        
        var net_used_in_kb = " - "
        var net_available_in_kb = " - "
        var net_stake = " - "
        var net_percentage = 0
        if let net_limit = account_data.net_limit, let net_stake_ = account_data.net_weight{
            
            if let available = net_limit.available{
                net_available_in_kb = getSizeString(sizeInBytes: Double(available))
                net_available_in_kb = net_available_in_kb.replacingOccurrences(of: ".", with: ",")
            }
            
            if let used = net_limit.used{
                net_used_in_kb = getSizeString(sizeInBytes: Double(used))
                net_used_in_kb = net_used_in_kb.replacingOccurrences(of: ".", with: ",")
            }
            
            net_stake = String(net_stake_)
            
            if let available = net_limit.available, let used = net_limit.used{
                net_percentage = Int(Double(used) / Double(available)) * 100
            }
        }
        
        DispatchQueue.main.async {
            self.eos_profile_viewController?.setNetStake(stringNetValue: net_stake, stringNetUsed: net_used_in_kb, stringNetTotal: net_available_in_kb, percentage: net_percentage)
        }
        
        
        var cpu_used_in_kb = " - "
        var cpu_available_in_kb = " - "
        var cpu_stake = " - "
        var cpu_percentage = 0
        if let cpu_limit = account_data.cpu_limit, let cpu_stake_ = account_data.cpu_weight{
            
            if let available = cpu_limit.available{
                cpu_available_in_kb = "\(String(Double(available) / 1000)) ms"
                cpu_available_in_kb = cpu_available_in_kb.replacingOccurrences(of: ".", with: ",")
            }
            
            if let used = cpu_limit.used{
                cpu_used_in_kb = "\(String(Double(used) / 1000)) ms"
                cpu_used_in_kb = cpu_used_in_kb.replacingOccurrences(of: ".", with: ",")
            }
            
            cpu_stake = String(cpu_stake_)
            
            if let available = cpu_limit.available, let used = cpu_limit.used{
                cpu_percentage = Int((Double(used)/Double(available)) * 100.0)
            }
        }
        
        DispatchQueue.main.async {
            self.eos_profile_viewController?.setCPUStake(stringCPUValue: cpu_stake, stringCPUUsed: cpu_used_in_kb, stringCPUTotal: cpu_available_in_kb, percentage: cpu_percentage)
        }
        
        var ram_qouta_in_kb = " - "
        var ram_used_in_kb = " - "
        if let ram_quota = account_data.ram_quota{
            ram_qouta_in_kb = getSizeString(sizeInBytes: Double(ram_quota))
        }
        
        if let ram_usage = account_data.ram_usage{
            ram_used_in_kb = getSizeString(sizeInBytes: Double(ram_usage))
        }
        
        var ram_percentage = 0
        if let ram_quota = account_data.ram_quota, let ram_usage = account_data.ram_usage{
            ram_percentage = Int(Double(ram_usage) / Double(ram_quota) * 100.0)
        }
        
        DispatchQueue.main.async {
            self.eos_profile_viewController?.setRAMUsed(stringRAMUsed: ram_used_in_kb, stringRAMTotal: ram_qouta_in_kb, percentage: ram_percentage)
        }
    }
    
    //MARK: - Convert bytes to KB, MB or BG
    func getSizeString(sizeInBytes: Double) -> String{
        
        var finalString = "byte"
        
        if sizeInBytes > 0{
            if sizeInBytes <= 999{
                finalString = String(format: "%.2f bytes", sizeInBytes)
            }
            else{
                //Converting the bytes in to KB at this point
                let kb_value = sizeInBytes / 1000.0
                
                if kb_value <= 999{
                    finalString = String(format: "%.2f KB", kb_value)
                }
                else{
                    //Converting the KB in to MB at this point
                    let mb_value = kb_value / 1000.0
                    
                    if mb_value <= 999{
                        finalString = String(format: "%.2f MB", mb_value)
                    }
                    else{
                        //Converting the MB in to GB at this point
                        let gb_value = mb_value / 1000
                        
                        if gb_value <= 999{
                            finalString = String(format: "%.2f GB", gb_value)
                        }
                    }
                }
            }
        }
        
        return finalString
    }
}
