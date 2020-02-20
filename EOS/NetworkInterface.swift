//
//  NetworkInterface.swift
//  EOS
//
//  Created by Goutham Devaraju on 19/02/20.
//  Copyright © 2020 Goutham. All rights reserved.
//

import Foundation

let CONTENTTYPE = "Content-Type"
let APPLICATION_JSON = "application/json"
let FORM_URL_ENCODE =  "application/x-www-form-urlencoded"
let ACCEPT =  "Accept"
let XREQUESTID = "X-RequestId"

enum DataErrors : Error {
    case invalidJSONData
    case dataParseError
    case noData
}

enum NetworkError : Error {
    case httpStatus201
    case httpStatus204
    case httpStatus400
    case httpStatus404
    case httpStatus410
    case httpStatusUnknownError
}

enum RequestType {
    case get_account
}

struct RequestConstants {
    static let BaseURL = "https://api.eosnewyork.io/v1/chain/"
}

class NetworkRequests {
    
    static func BaseURL() -> String {
        let baseURL = RequestConstants.BaseURL
        return baseURL
    }
    
    //MARK: - GET Requests
    static func getRequestofType(_ requestType:RequestType, headers:NSDictionary?,  urlParams:NSDictionary?) -> URLRequest {
        
        var request:URLRequest!
        
        switch requestType {
            
        case .get_account:
            let path = "get_account"
            let endpoint = RequestConstants.BaseURL + path
            request = self.createGETRequest(endpoint, headers: headers, urlParams: urlParams)
            break
            //        default:
            //            break
        }
        
        return request
    }
    
    static func createGETRequest(_ baseURL:String , headers:NSDictionary?, urlParams:NSDictionary?) -> URLRequest {
        
        var headerAsString:String = ""
        
        if (urlParams != nil && urlParams!.count > 0) {
            
            for (_,value) in urlParams! {
                headerAsString += value as! String
            }
        }
        
        let fullUrlString = baseURL + headerAsString;
        let urlPath = NSString(format: fullUrlString as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
        let url = URL(string: urlPath)
        let request = NSMutableURLRequest(url: url!)
        print(fullUrlString)
        print(headers!)
        
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    
    
    
    
    //MARK: - POST Requests
    static func postRequestofType(_ requestType:RequestType ,headers:NSDictionary?, urlParams:NSDictionary?, payload :[String:Any]? ) -> URLRequest {
        
        var request:URLRequest!
        
        switch requestType {
            
        case .get_account:
            let authPath = "get_account"
            let endpoint = RequestConstants.BaseURL + authPath
            request = self.createPOSTRequest(endpoint, headers: headers,urlParams: urlParams, payload: payload!)
            break
            
            //        default:
            //            break
        }
        return request
    }
    
    
    static func createPOSTRequest(_ baseURL:String ,headers:NSDictionary?,urlParams: NSDictionary?, payload:[String:Any]) -> URLRequest {
        
        var headerAsString:String = ""
        
        if (urlParams != nil && urlParams!.count > 0) {
            for (key,_) in urlParams! {
                headerAsString += key as! String
            }
        }
        
        let fullUrlString = baseURL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        
        if headers != nil {
            for (key,value) in headers! {
                request.addValue(value as! String, forHTTPHeaderField: key as! String)
            }
        }
        
        do{
            let data = try JSONSerialization.data(withJSONObject: payload, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            request.httpBody = post.data(using: String.Encoding.utf8);
        }catch {
            print("json error: \(error)")
        }
        
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        
        return request as URLRequest
    }
    
    
    
}


typealias RequestCompletionType = (Bool, Data?, HTTPURLResponse?, Error?, [AnyHashable:Any]?) -> (Void)

class NetworkInterface: NSObject {
    
    static func getRequest(_ requestType:RequestType , headers:NSDictionary? = [:], params:NSDictionary? = [:], requestCompletionHander:@escaping RequestCompletionType) -> URLSessionDataTask {
        
        return self.sendAsyncRequest(NetworkRequests.getRequestofType(requestType, headers: headers, urlParams: params)) { (success, data, response, error, headers) -> (Void) in
            
            if (success == true && response != nil) {
                
                let httpResponse: HTTPURLResponse = response!
                let httpStatusCode = httpResponse.statusCode
                
                switch httpStatusCode {
                    
                case 200:
                    let succcess = (data != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, data, response, nil, httpResponse.allHeaderFields)
                    } else {
                        requestCompletionHander(false, nil, response , DataErrors.invalidJSONData, httpResponse.allHeaderFields)
                    }
                    break
                case 204:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus204, httpResponse.allHeaderFields)
                    break
                case 404:
                    requestCompletionHander(false,nil,response, NetworkError.httpStatus404, httpResponse.allHeaderFields)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus410, httpResponse.allHeaderFields)
                    break
                default:
                    requestCompletionHander(false,nil,response,NetworkError.httpStatusUnknownError, httpResponse.allHeaderFields)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error, nil)
            }
        }
    }
    
    static func postRequest(_ requestType: RequestType, headers: NSDictionary? = [:], params: NSDictionary? = [:],  payload :[String:Any], requestCompletionHander:@escaping RequestCompletionType) -> URLSessionDataTask{
        
        return self.sendAsyncRequest(NetworkRequests.postRequestofType(requestType, headers: headers, urlParams:params, payload: payload  ), completionHandler: { (success, json, response, error, headers) -> (Void) in
            
            if (success == true && response != nil) {
                
                let httpResponse: HTTPURLResponse = response!
                let httpStatusCode = httpResponse.statusCode
                
                switch httpStatusCode {
                    
                case 200:
                    let succcess = (json != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, json, response, nil, httpResponse.allHeaderFields)
                    } else {
                        requestCompletionHander(false, nil, response , DataErrors.invalidJSONData, httpResponse.allHeaderFields)
                    }
                    break
                case 204:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus204, httpResponse.allHeaderFields)
                    break
                case 404:
                    requestCompletionHander(false,nil,response, NetworkError.httpStatus404, httpResponse.allHeaderFields)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, NetworkError.httpStatus410, httpResponse.allHeaderFields)
                    break
                default:
                    requestCompletionHander(false,nil,response,NetworkError.httpStatusUnknownError, httpResponse.allHeaderFields)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error, nil)
            }
            
        })
    }
    
    
    static fileprivate func sendAsyncRequest(_ request:URLRequest, completionHandler:@escaping RequestCompletionType) -> URLSessionDataTask{
        
        let task = URLSession.shared.dataTask(with: request) { ( data_,response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data_, let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(false, nil, nil, DataErrors.invalidJSONData, nil)
                    return
                }
                
                completionHandler(true, data, httpUrlResponse, nil, httpUrlResponse.allHeaderFields)
            }
        }
        
        task.resume()
        return task
    }
}
