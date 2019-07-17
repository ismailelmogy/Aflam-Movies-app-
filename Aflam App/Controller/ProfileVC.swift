//
//  ProfileVC.swift
//  Aflam App
//
//  Created by Esraa Hassan on 7/11/19.
//  Copyright © 2019 Developers. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let alertTitle :String? = "Alert Authentication"
    let positiveButtonText = "OK"
    var alertMessage : String? = nil
    var requestToken : String?
    var userName : String?
    var password :String?
    var sessionId :String?
    let def = UserDefaults.standard
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if let userName = def.object(forKey: Utils.USER_NAME) as? String , let password = def.object(forKey: Utils.PASSWORD) as? String {
            self.userName = userName
            self.password = password
        }
        
        loadGravatar()
    }
    
    
    func loadGravatar(){
        
        APICallManager.instance.getRequestToken{ (result :String?) in
            guard let request = result , !request.isEmpty else{
                self.alertMessage = "Fail to get user Information "
                Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil);
                return
            }
            self.requestToken = result
            APICallManager.instance.login(userName: self.userName!, password: self.password!, requestToken: self.requestToken!, completionHandeler:
                { (error : Error?, authentication : Bool ,success : Bool) in
                    
                    if success && authentication {
                        APICallManager.instance.getSessionId(requestToken: self.requestToken!, completionHandeler: { (error :Error?, authentication: Bool, sessionId : String) in
                            if authentication{
                                self.sessionId = sessionId
                                print("go to authentication")
                                print("session ID : \(sessionId)")
                                APICallManager.instance.getUserInformation(sessionId: self.sessionId!
                                    , completionHandeler: { (error:Error?, success:Bool, gravatarHash:String,userName : String) in
                                        if success{
                                            
                                            self.userNameLbl.text = userName
                                            self.profileImg.sd_setImage(with: URL(string: URLS.BASE_GRAVATAR_URL + gravatarHash), placeholderImage: UIImage(named: "1.jpg"))
                                            self.activityIndicator.stopAnimating()
                                            self.activityIndicator.isHidden = true
                                        }
                                        else{
                                            self.failToGetUserInformation()
                                        }
                                })
                            }
                            else{
                                self.failToGetUserInformation()
                            }
                        })
                    }
                        
                    else {
                        self.failToGetUserInformation()
                    }
            })
            
            
        }
    }
    
    func failToGetUserInformation()-> Void{
        self.alertMessage = "Fail to get user Information"
        Utils.sharedInstance.showAlertView(title: self.alertTitle , message: self.alertMessage!, actionTitles:  [self.positiveButtonText],actions: nil)
    }
    
    
    
}
