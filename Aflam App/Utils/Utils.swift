//
//  Utils.swift
//  Movies App
//
//  Created by Esraa Hassan on 7/9/19.
//  Copyright © 2019 Developers. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static let USER_NAME = "user_name"
    static let PASSWORD = "password"
    static let ERROR = "error"
    static let TOP_RATED_RESPONSE = "top rated response"
    static let POPULAR_RESPONSE = "popular response"
    static let GRAVATAR_HASH = "gravatar hash"
    var rootWindow: UIWindow!
    
    // Singleton.
    class var sharedInstance: Utils {
        struct Static {
            static let instance: Utils = Utils()
        }
        return Static.instance
    }
    
    private override init() {}
    
    // show alert.
    func showAlertView(
        title: String? = nil,
        message: String,
        actionTitles: [String],
        actions: [() -> ()]?) {
        // create new window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.clear
        window.rootViewController = UIViewController()
        Utils.sharedInstance.rootWindow = UIApplication.shared.windows[0]
        //create alertview.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        for title in actionTitles {
            //add action.
            let action = UIAlertAction(title: title, style: .default, handler: { (action : UIAlertAction) -> Void in
                if let acts = actions {
                    if acts.count >= actionTitles.count {
                        acts[actionTitles.index(of: title)!]()
                    }
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    alert.dismiss(animated: true, completion: nil)
                    window.isHidden = true
                    window.removeFromSuperview()
                    Utils.sharedInstance.rootWindow.makeKeyAndVisible()
                })
            })
            alert.addAction(action)
        }
        
        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}



