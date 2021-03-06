//
//  APIClient.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

import Alamofire
import KeychainSwift

typealias JSONObject = [String: Any]
typealias JSONArray = [ JSONObject ]

typealias APIClientBoolCompletion = (_ success: Bool, _ dataJSON: JSONObject?, _ message: String?) -> Void

enum APIClientKeys {
    static let data = "data"
    static let username = "username"
    static let userId = "userId"
    static let message = "message"
    static let code = "code"
    static let password = "password"
    static let email = "email"
    static let accessToken = "id"
    static let filter = "filter"
    static let id = "id"
    static let mentoring = "mentoring"
    static let mentorId = "mentorId"
}



class APIClient {
    
    static let sharedInstance: APIClient = APIClient()
    
    fileprivate let keychainHandler = KeychainHandler()

//    private init() {
//        let _ = updateOAuth2Handler()
////        addUserLoginObserver()
//    }
//
//    deinit {
//        removeUserLoginObserver()
//    }
    
    fileprivate var oauthHandler: OAuth2Handler? = nil {
        didSet {
            self.sessionManager.adapter = self.oauthHandler
        }
    }
    
    lazy fileprivate var sessionManager: SessionManager = {
        let _sessionManager = SessionManager()
        if let _oauthHandler = oauthHandler {
           // _sessionManager.adapter = _oauthHandler
        }
        return _sessionManager
    }()
    
    //MARK: -
//    fileprivate func updateOAuth2Handler() -> Bool {
//        guard tokensExist(),
//            //let user = StorageManager.shared.getLoggedInUser(),
//            let username = user.username else {
//                self.oauthHandler = nil
//                return false
//        }
//
//        self.oauthHandler = OAuth2Handler(username: username, keychainHandler: self.keychainHandler)
//        return true
//    }
    
    //MARK: - Base request
    fileprivate func performAuthorizedRequest(method: HTTPMethod, path: String,
                                    parameters: [String: Any]?, headers: [String: String]?,
                                    callback: @escaping (APIClientBoolCompletion)) {
        if let accessToken = keychainHandler.getAccessToken() {
            let authPath =  path + "?access_token=" + accessToken
            performRequest(method: method, path: authPath, parameters: parameters, headers: headers, callback: callback)
        } else {
            fatalError()
        }
        
    }
    
    
    fileprivate func performRequest(method: HTTPMethod, path: String,
                                    parameters: [String: Any]?, headers: [String: String]?,
                                    callback: @escaping (APIClientBoolCompletion)) {
        
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let request = sessionManager.request(path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            
           // UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch response.result {
            case .success:
                
//                guard let json = response.result.value as? JSONObject else {
//                        callback(false, nil, "Bad response JSON")
//                        return
//                }
                let message = "Success"
                print(message)
                
                if let dataJSON = response.result.value as? JSONObject {
                    callback(true, dataJSON, message)
                    return
                } else if let jsonArray = response.result.value as? JSONArray {
                    callback(true, [APIClientKeys.data: jsonArray], message)
                    return
                } else {
                    callback(true, nil, "Bad response JSON")
                    return
                }
                
                //callback(true, json, message)
                
            case .failure(let error):
                let message = error.localizedDescription
                callback(false, nil, message)
            }
        }
        print(request)
}
    
    //MARK: -
    func tokensExist() -> Bool{
        return keychainHandler.tokenExist
    }
    
    func userIdExist() -> Bool {
        return keychainHandler.userIdExist
    }
    
    fileprivate func clearTokens() {
        keychainHandler.clearAccessToken()
        keychainHandler.clearUserId()
    }
    
    func logout() {
        clearTokens()
    }
}

//MARK: Base methods
extension APIClient {
    //LogIn request
    func logInRequest(parameters: JSONObject?,
                       callback: @escaping (APIClientBoolCompletion)) {
        performRequest(method: .post, path: URLBuilder.logInPath, parameters: parameters, headers: [:]) {[weak self] (success, dataJSON, message) in
            if success,
                let strongSelf = self {
                let tokensUpdateResult = strongSelf.updateTokens(dataJSON, message)
                callback(tokensUpdateResult.success, dataJSON, tokensUpdateResult.message)
            } else {
                callback(success, dataJSON, message)
            }
        }
    }
    
    fileprivate func updateTokens(_ dataJSON: JSONObject?, _ message: String?) -> (success: Bool, message: String?) {
        if let dataJSON = dataJSON,
            let accessToken = dataJSON[APIClientKeys.accessToken] as? String,
            let userId = dataJSON[APIClientKeys.userId] as? Int64 {
            
            keychainHandler.storeAccessToken(accessToken)
            keychainHandler.storeUserId(userId)
            print("****** APP TOKEN WAS OBTAINED AND SAVED ******")
            return (true, message)
            
        } else {
            print("****** APP TOKENS OBTAINING FAILED ******")
            let _message = (message ?? "") + "APP TOKENS OBTAINING FAILED"
            return (false, _message)
        }
    }
//
    // Sign Up request
    func signUpRequest(parameters: JSONObject?, callback: @escaping (APIClientBoolCompletion)) {
        performRequest(method: .post, path: URLBuilder.createUserPath, parameters: parameters, headers: [:], callback: callback)
    }
    
    fileprivate func authorizedPath(formPath path: String) -> String? {
        if let accessToken = keychainHandler.getAccessToken() {
            return path + "?access_token=" + accessToken
        }
        return nil
    }
    
    func getUser(withID id: String, callback: @escaping (APIClientBoolCompletion)) {
        let path = URLBuilder.getUserPath + "\(id)"
        if let authPath = authorizedPath(formPath: path) {
            performRequest(method: .get, path: authPath, parameters: nil, headers: nil, callback: callback)
        } else {
            fatalError()
        }
    }
    
    func getDistricts(callback: @escaping (APIClientBoolCompletion)) {
        let params: JSONObject = ["filter" : ["include" : [ "relation" : "schools"]]]
        performAuthorizedRequest(method: .get, path: URLBuilder.districtsPath, parameters: params, headers: [:], callback: callback)
    }
    
    func getSchools(callback: @escaping (APIClientBoolCompletion)) {
        performAuthorizedRequest(method: .get, path: URLBuilder.schoolsPath, parameters: [:], headers: [:], callback: callback)
    }
    
    func getSchoolGroups(id: Int64, callback: @escaping (APIClientBoolCompletion)) {
        let path = URLBuilder.schoolsPath + "/\(id)/groups"
        performAuthorizedRequest(method: .get, path: path, parameters: [:], headers: [:], callback: callback)
    }
    
    func getGroups(callback: @escaping (APIClientBoolCompletion)) {
        performAuthorizedRequest(method: .get, path: URLBuilder.groupsPath, parameters: [:], headers: [:], callback: callback)
    }
    
    func getGroup(id: Int64, callback: @escaping (APIClientBoolCompletion)) {
        
        let path = URLBuilder.groupsPath + "/\(id)"
        
        performAuthorizedRequest(method: .get, path: path, parameters: [:], headers: [:], callback: callback)
    }
    
    func getTeacherForGroup(id: Int64, callback: @escaping (APIClientBoolCompletion)) {
        let path = URLBuilder.groupsPath + "/\(id)/teacher"
        performAuthorizedRequest(method: .get, path: path, parameters: [:], headers: [:], callback: callback)
    }
    
    func getMyGroups(callback: @escaping (APIClientBoolCompletion)) {
        guard let id = keychainHandler.getUserId() else {
            fatalError()
        }
        let params: JSONObject = ["filter" : ["include" : [ "relation" : "mentoring", "scope" : ["include": ["schools"]]]]]
        let path = URLBuilder.getUserPath + "\(id)"
        
        performAuthorizedRequest(method: .get, path: path, parameters: params, headers: [:], callback: callback)
    }
    
    func subscribeToGroup(groupId: Int64, subscribe: Bool, callback: @escaping (APIClientBoolCompletion)) {
        
        guard let id = keychainHandler.getUserId() else {
            fatalError()
        }
        
        //let mentorId = subscribe ? id : 0
        var params: JSONObject = [:]
        
        if subscribe {
         params = [APIClientKeys.mentorId : id]
        } else {
            params = [APIClientKeys.mentorId : NSNull()]
        }
        
        let path = URLBuilder.groupsPath + "/\(groupId)"
        
        performAuthorizedRequest(method: .patch, path: path, parameters: params, headers: [:], callback: callback)
    }
    
    //{"include": ["mentoring", "teaching"]}  Groups/1
}




class OAuth2Handler: RequestAdapter {
 
    private var keychainHandler: KeychainHandler

    
    // MARK: - Initialization
    public init(keychainHandler: KeychainHandler) {
        self.keychainHandler = keychainHandler
    }
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let accessToken = keychainHandler.getAccessToken() {
            var urlRequest = urlRequest
            urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization: ")
            
            print("TOKEN:\n \(accessToken) \n")
            
            return urlRequest
        }
        
        return urlRequest
    }
  
}

class KeychainHandler {
    
    let accessTokenKey = "accessToken"
    let userIdKey = "userID"
    
    var tokenExist: Bool {
        get {
            if let _ = getAccessToken() {
                return true
            } else {
                return false
            }
        }
    }
    
    var userIdExist: Bool {
        get {
            if let _ = getUserId() {
                return true
            } else {
                return false
            }
        }
    }
    
    func storeAccessToken(_ accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: accessTokenKey)
    }
    
    func getAccessToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(accessTokenKey)
    }
    
    func clearAccessToken() {
        let keychain = KeychainSwift()
        keychain.delete(accessTokenKey)
    }
    
    func storeUserId(_ id: Int64) {
        let keychain = KeychainSwift()
        keychain.set("\(id)", forKey: userIdKey)
    }
    
    func getUserId() -> Int64? {
        let keychain = KeychainSwift()
        if let idString = keychain.get(userIdKey) {
            return Int64(idString)
        }else {
            return nil
        }
    }
    
    func clearUserId() {
        let keychain = KeychainSwift()
        keychain.delete(userIdKey)
    }
    
    
    func clearKechain() {
        let keychain = KeychainSwift()
        keychain.clear()
    }
}
