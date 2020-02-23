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
    @IBOutlet var labelNetUsed: UILabel!
    @IBOutlet var labelNetTotal: UILabel!
    @IBOutlet var labelNetStake: UILabel!
    @IBOutlet var labelNetPercentage: UILabel!
    @IBOutlet var progressNET: UIProgressView!
    
    @IBOutlet var viewCpu: UIView!
    @IBOutlet var labelCpuUsed: UILabel!
    @IBOutlet var labelCpuTotal: UILabel!
    @IBOutlet var labelCpuStake: UILabel!
    @IBOutlet var labelCPUPercentage: UILabel!
    @IBOutlet var progressCPU: UIProgressView!
    
    @IBOutlet var viewRam: UIView!
    @IBOutlet var labelRAMUsed: UILabel!
    @IBOutlet var labelRAMTotal: UILabel!
    @IBOutlet var labelRAMPercentage: UILabel!
    @IBOutlet var progressRAM: UIProgressView!
    
    @IBOutlet var labelEOSTokenBalance: UILabel!
    @IBOutlet var labelUSDollarValue: UILabel!
    @IBOutlet var labelStaked: UILabel!
    
    
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
    
    func setEOSBalance(stringEOSBalance: String){
        labelEOSTokenBalance.text = stringEOSBalance
    }
    
    func setStakedValue(stringStakedValues: String) {
        labelStaked.text = stringStakedValues
    }
    
    func setNetStake(stringNetValue: String, stringNetUsed: String, stringNetTotal: String, percentage: Int) {
        
        labelNetUsed.text = stringNetUsed
        labelNetTotal.text = stringNetTotal
        labelNetStake.text = stringNetValue
        labelNetPercentage.text = "\(String(percentage))%"
        progressNET.progress = Float(percentage)/100.0
    }
    
    func setCPUStake(stringCPUValue: String, stringCPUUsed: String, stringCPUTotal: String, percentage: Int) {
        
        labelCpuUsed.text = stringCPUUsed
        labelCpuTotal.text = stringCPUTotal
        labelCpuStake.text = stringCPUValue
        labelCPUPercentage.text = "\(String(percentage))%"
        progressCPU.progress = Float(percentage)/100.0
    }
    
    func setRAMUsed(stringRAMUsed: String, stringRAMTotal: String, percentage: Int) {
        
        labelRAMUsed.text = stringRAMUsed
        labelRAMTotal.text = stringRAMTotal
        labelRAMPercentage.text = "\(String(percentage))%"
        progressRAM.progress = Float(percentage)/100.0
    }
    
}
