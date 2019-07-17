
import UIKit
import Alamofire
import SwiftyJSON


class APICallManager {
    
    static let instance = APICallManager()
    func getRequestToken (completionHandler: @escaping (_ token:String?) -> Void){
        let url = URLS.CREATE_TOKEN_URL
        
        Alamofire.request(url)
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching request token: \(String(describing: response.result.error))")
                        completionHandler(nil)
                        return
                }
                let requestToken = JSON(value)["request_token"].stringValue
                print("request token:\(requestToken)")
                completionHandler(requestToken)
        }
    }
    
    
    func getSessionId(requestToken :String, completionHandeler : @escaping (_ error :Error? ,_ authentication : Bool, _ sessionId : String  )-> Void){
        
        let createSessionId : String = URLS.CREATE_SESSION_ID_URL
        let parameters = [
            "request_token" : requestToken
        ]
        
        Alamofire.request(createSessionId, method: .post, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json  = JSON(value)
                    print("\(json)")
                    if let success = json["success"].int , success == 1
                    {
                        let sessionId = json["session_id"].string
                        print("The value of success is: \(success)")
                        completionHandeler(nil,true,sessionId!)
                    }
                    else {
                        completionHandeler(nil ,false, "no session id")
                    }
                    
                case .failure(let error):
                    completionHandeler(error,false ,"no session id")
                    print (error)
                    
                }
                
        }
        
        
    }
    
    func getUserInformation(sessionId :String, completionHandeler : @escaping (_ error :Error? ,_ success : Bool, _ gravatarHash : String , _ userName :String )-> Void){
        
        let accountInformtionUrl : String = URLS.ACCOUNT_INFROMATION_URL
        let parameters = [
            "session_id" : sessionId
        ]
        
        
        Alamofire.request(accountInformtionUrl, method: .get, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json  = JSON(value)
                    print("\(json)")
                    if let userName = json["username"].string
                    {
                        let gravatar = json["avatar"]["gravatar"]["hash"].string
                        print("hash: \(String(describing: gravatar))")
                        completionHandeler(nil,true,gravatar!,userName)
                    }
                        
                    else {
                        completionHandeler(nil,false,"no gravatar","no user name")
                    }
                    
                    
                case .failure(let error):
                    completionHandeler(error,false ,"no gravatar","no user name")
                    print (error)
                    
                }
                
        }
        
        
    }
    
    func login(userName : String , password :String ,requestToken :String, completionHandeler : @escaping (_ error :Error? ,_ authentication : Bool, _ success : Bool  )-> Void){
        
        let loginUrl : String = URLS.LOGIN_URL
        let parameters = [
            "username": userName ,
            "password": password ,
            "request_token" : requestToken
        ]
        
        Alamofire.request(loginUrl, method: .post, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json  = JSON(value)
                    print("\(json)")
                    if let success = json["success"].int , success == 1
                    {
                        print("The value of success is: \(success)")
                        completionHandeler(nil,true,true)
                    }
                    else {
                        completionHandeler(nil ,false, true)
                    }
                    
                case .failure(let error):
                    completionHandeler(error,false ,false)
                    print (error)
                    
                }
                
        }
        
        
    }
    
}

