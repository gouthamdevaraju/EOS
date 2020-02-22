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
    
    @IBOutlet var buttonBuy: UIButton!
    @IBOutlet var buttonSend: UIButton!
    @IBOutlet var buttonReceive: UIButton!
    
    @IBOutlet var viewNet: UIView!
    @IBOutlet var viewCpu: UIView!
    @IBOutlet var viewRam: UIView!
    
    @IBOutlet var constraint_stack_bottom: NSLayoutConstraint!
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialising presenter objects
        self.eosProfilePresenter = EOSProfilePresenter(view: self)
        
        //Fetching profile data initially
        fetchEOSProfileAPI()
        configureButtonShadows()
        configureViewShadows()
        configureStackBottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Making navigation bar tranparent
        setNavigationBarTransparesnt()
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
            
            setNavigationTitle(stringAccountName: account_name)
        }
        else{
            print("Account name not found")
        }
    }
    
    //MARK: - Other Methods
    func setNavigationBarTransparesnt(){
        
        let nav = self.navigationController?.navigationBar
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.isTranslucent = true
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func configureButtonShadows(){
        
        buttonBuy.layer.shadowColor = UIColor.black.cgColor
        buttonBuy.layer.shadowOpacity = 0.2
        buttonBuy.layer.shadowRadius = 2
        buttonBuy.layer.shadowOffset = CGSize(width: 0, height: 1)
        buttonBuy.layer.cornerRadius = 5
        
        buttonSend.layer.shadowColor = UIColor.black.cgColor
        buttonSend.layer.shadowOpacity = 0.2
        buttonSend.layer.shadowRadius = 2
        buttonSend.layer.shadowOffset = CGSize(width: 0, height: 1)
        buttonSend.layer.cornerRadius = 5
        
        buttonReceive.layer.shadowColor = UIColor.black.cgColor
        buttonReceive.layer.shadowOpacity = 0.2
        buttonReceive.layer.shadowRadius = 2
        buttonReceive.layer.shadowOffset = CGSize(width: 1, height: 1)
        buttonReceive.layer.cornerRadius = 5
    }
    
    func configureViewShadows(){
        
        viewCpu.layer.shadowColor = UIColor.black.cgColor
        viewCpu.layer.shadowOpacity = 0.2
        viewCpu.layer.shadowRadius = 2
        viewCpu.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewCpu.layer.cornerRadius = 10
        
        viewRam.layer.shadowColor = UIColor.black.cgColor
        viewRam.layer.shadowOpacity = 0.2
        viewRam.layer.shadowRadius = 2
        viewRam.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewRam.layer.cornerRadius = 10
        
        viewNet.layer.shadowColor = UIColor.black.cgColor
        viewNet.layer.shadowOpacity = 0.2
        viewNet.layer.shadowRadius = 2
        viewNet.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewNet.layer.cornerRadius = 10
    }
    
    func configureStackBottom(){
        
        let modelName = UIDevice.modelName
            
        if modelName.contains("iPhone 5"){
            constraint_stack_bottom.constant = 10;
        }
        else if modelName.contains("iPhone 6s"){
            constraint_stack_bottom.constant = 30;
        }
        else if modelName.contains("iPhone 6 Plus"){
            constraint_stack_bottom.constant = 40;
        }
        else if modelName.contains("iPhone XS Max"){
            constraint_stack_bottom.constant = 70;
        }
        else if modelName.contains("iPhone XS"){
            constraint_stack_bottom.constant = 30;
        }
        
    }
    
    func setNavigationTitle(stringAccountName: String){
        title = stringAccountName
    }
    
}
