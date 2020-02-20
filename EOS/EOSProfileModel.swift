//
//  EOSProfileModel.swift
//  EOS
//
//  Created by Goutham Devaraju on 19/02/20.
//  Copyright © 2020 Goutham. All rights reserved.
//

import Foundation

struct AccountModel: Codable {
    
    var account_name: String?
    var head_block_num: Int?
    var head_block_time: String?
    var privileged: Bool?
    var last_code_update: String?
    var created: String?
    var core_liquid_balance: String?
    var ram_quota: Int?
    var net_weight: Int?
    var cpu_weight: Int?
    
    let net_limit: NetLimit?
    struct NetLimit: Codable {
        
        var used: Int?
        var available: Int?
        var max: Int?
    }
    
    var ram_usage: Int?
    
    let permissions: [Permissions]?
    struct Permissions: Codable {
        
        var perm_name: String?
        var parent: String?
        
        let required_auth: RequiredAuth?
        struct RequiredAuth: Codable {
            
            var threshold: Int?
            
            let keys: [Keys]?
            struct Keys: Codable {
                
                var key: String?
                var weight: Int?
            }
            
            let accounts: [Accounts]?
            struct Accounts: Codable {
                
                let permission: Permission?
                struct Permission: Codable {
                    
                    var actor: String?
                    var permission: String?
                }
                
                var weight: Int?
            }
            
            let waits: [Waits]?
            struct Waits: Codable {
                   
            }
        }
    }
    
    
    let total_resources: TotalResources?
    struct TotalResources: Codable {
        
        var owner: String?
        var net_weight: String?
        var cpu_weight: String?
        var ram_bytes: Int?
    }
    
    let self_delegated_bandwidth: SelfDelegatedBandwidth?
    struct SelfDelegatedBandwidth: Codable {
        
        var from: String?
        var to: String?
        var net_weight: String?
        var cup_weight: String?
    }
    
    var refund_request: String?
    
    let voter_info: VoterInfo?
    struct VoterInfo: Codable {
        
        var owner: String?
        var proxy: String?
        
        let producers: [Producers]?
        struct Producers: Codable {
            
        }
        
        var staked: Int?
        var last_vote_weight: String?
        var proxied_vote_weight: String?
        var is_proxy: Int?
        var flags1: Int?
        var reserved2: Int?
        var reserved3: String?
    }
    
    var rex_info: String?
    
}
