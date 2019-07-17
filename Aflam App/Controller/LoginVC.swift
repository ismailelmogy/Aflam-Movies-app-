
//
//  ViewController.swift
//  Movies App
//
//  Created by Esraa Hassan on 7/7/19.
//  Copyright © 2019 Developers. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let alertTitle :String? = "Alert Authentication"
    let positiveButtonText = "OK"
    var alertMessage : String? = nil
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var requestToken : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let userName = userNameTF.text ,!userName.isEmpty else{
            self.alertMessage = "User Name is Empty"
            Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil)
            return
        }
        
        guard let password = passwordTF.text , !password.isEmpty else {
            self.alertMessage = "Password is Empty"
            Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil)
            return
        }
        
        APICallManager.instance.getRequestToken { (result :String?) in
            
            guard let request = result , !request.isEmpty else{
                self.alertMessage = "Fail to get request token...Please Try again"
                Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil);                return
            }
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.requestToken = result
            
            APICallManager.instance.login(userName: self.userNameTF.text!, password: self.passwordTF.text!, requestToken: self.requestToken!, completionHandeler:
                { (error : Error?, authentication : Bool ,success : Bool) in
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    if success && authentication {
                        let def = UserDefaults.standard
                        def.setValue(self.userNameTF.text!, forKey: Utils.USER_NAME)
                        def.setValue(self.passwordTF.text!, forKey: Utils.PASSWORD)
                        def.synchronize()
                        self.navigateToMainVC()
                        print("success")
                        
                    }
                    else if success == true && authentication == false {
                        self.alertMessage = "Invalid username or password: You did not provide a valid login"
                        Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil)
                    }
                    else {
                        self.alertMessage = "Failure in server.Please Try again"
                        Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil)
                    }
            })
            
            
        }
        
    }
    
    
    func navigateToMainVC() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "main")
        self.present(tab, animated:true, completion:nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}

