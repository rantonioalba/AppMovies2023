//
//  ApiManager.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 17/02/23.
//

import Foundation
import UIKit
import CoreData
import CoreGraphics

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

enum APIURL {
    case REQUEST_TOKEN
    case LOGIN
    case SESSION
    case POPULAR_SHOW
    case TOP_RATED
    case ON_TV
    case AIRING_TODAY
    case PROVIDERS_TV (idShowTV:Int)
    case GENRES
    case COUNTRIES
    case DELETE_SESSION
    case PROFILE
}

extension APIURL:EndPoint {
    var base: String {
        switch self {
        default:
        return "https://api.themoviedb.org" //QA
        }
    }
    
    var path: String {
        switch self {
        case .REQUEST_TOKEN:
            return "/3/authentication/token/new"
        case .LOGIN:
            return "/3/authentication/token/validate_with_login"
        case .SESSION:
            return "/3/authentication/session/new"
        case .POPULAR_SHOW:
            return "/3/tv/popular"
        case .TOP_RATED:
            return "/3/tv/top_rated"
        case .ON_TV:
            return "/3/tv/on_the_air"
        case .AIRING_TODAY:
            return "/3/tv/airing_today"
        case .PROVIDERS_TV(let idShowTV):
            return "/3/tv/\(idShowTV)/watch/providers"
        case .GENRES:
            return "/3/genre/tv/list"
        case .COUNTRIES:
            return "/3/configuration/countries"
        case .DELETE_SESSION:
            return "/3/authentication/session"
        case .PROFILE:
            return "/3/account"
        }
    }
}
        
extension URLSession {
    func synchronousDataTask(urlRequest:URLRequest) -> (data:Data?,response:URLResponse?,error:Error?) {
        var data:Data?
        var response:URLResponse?
        var error:Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlRequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}

struct APICredentials{
    //Credentials
    static let userName = "userservicios"
    static let password = "75dc230a000b524b766d6d98765da918735f6c28"
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case cardWithoutFunds
    case noMoreThreeProducts
    case duplicated
    case productDeliveryInmediatlyFound
    case productDeliveryTo24HoursFound
    case productDeliveryOnlySucursalFound
    case combinationNoAvailable
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .cardWithoutFunds: return "Tarjeta sin fondos suficientes"
        case .noMoreThreeProducts: return "No puede agregar más de 3 productos, estos pedidos son directos en sucursal"
        case .duplicated: return "register duplicated"
        case .productDeliveryInmediatlyFound: return "Producto de entrega inmediata encontrado en el carrito"
        case .productDeliveryTo24HoursFound: return "Producto de entrega a 24 horas encontrado en el carrito"
        case .productDeliveryOnlySucursalFound: return "Producto de entrega solo en sucursal encontrado en el carrito"
        case .combinationNoAvailable: return "Combinación no disponible"
        }
    }
}


class APIManager{
    //Vars for OpenPay
    //TEST
    static let MERCHANT_ID = "mo0qtm4wstap8vtgaz73"
    static let API_KEY = "dcc838e2f42c3fb8d6efc55db75a54cd"
    
    static var session:Session?
    
    //PRODUCTION
//    static let MERCHANT_ID = "mmuulurcjur3do3le6p3"
//    static let API_KEY = "pk_039c1ef9ffb84781a8c3504076086f1e"

    
    static var apiURLSelected :  APIURL?
    
    class func fetchObjects<T>(apiURL:APIURL,completionHandler:@escaping (_ objects:[T]?, _ error:APIError?)->Void) where T:Decodable  {
        
        
            print(T.Type.self)
            
            APIManager.apiURLSelected = apiURL
            
            print(apiURL)
            
            var objects:[T]?
            
            //        guard let user = User.userDefault() else {
            //            return
            //        }
            
            
            
            //        let url = URL(string: "\(APIURL.SERVER)/\(APIURL.NOTIFICATIONS)/\(user.id)")
            
            //        let url = URL(string: "\(APIURL.SERVER.rawValue)/\(apiURL.rawValue)/\(user.id)")
            
            
        let urlString = apiURL.url
        
            let url = URL(string:urlString)
            
            var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0)
            
            //Autentificacion
            let loginData = NSString(format: "%@:%@", APICredentials.userName,APICredentials.password).data(using: String.Encoding.utf8.rawValue)!
            
            let base64LoginData = loginData.base64EncodedString()
            
            request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
            
            request.httpMethod = "GET"
            
            
            let device = 0
            request.setValue("\(device)", forHTTPHeaderField: "Device-Type")
            
            //            let post = NSString(format: "username=%@&password=%@", self.textMail.text!,self.textPassword.text!)
            //
            //            let data = post.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
            //
            //            let postLength = NSString(format: "%lu", (data?.count)!)
            //
            //            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //
            //            request.httpBody = data
            
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    print(error)
                    completionHandler(objects,APIError.requestFailed)
                    return
                }
                
                guard let response = response as? HTTPURLResponse
                    else {
                        print ("server response error")
                        completionHandler(objects,APIError.requestFailed)
                        return
                }
                
                print(response.statusCode)
                
                
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\(dataString)")
                    
//                     var dataString2 =  dataString.replacingOccurrences(of: "null", with: "")
                    
                    
                    
                }
                
                if response.statusCode == 200{
                    
                    DispatchQueue.main.async {
                        
                    
                    
                    
                    do{
                        
                        if let data = data {
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appDelegate.persistentContainer.viewContext
//                            let persistentContainer:NSPersistentContainer
                            
                            let decoder = JSONDecoder()
                            
                            guard let codingUserInfoManagedObjectContext = CodingUserInfoKey.managedObjectContext  else {
                                fatalError("Failed to retrieve context")
                                
                            }
                            
                            decoder.userInfo[codingUserInfoManagedObjectContext] = context
                            
                            let objects2 =  try decoder.decode([T].self, from: data)
                            
                            
//                            let objects2 = try JSONDecoder().decode([T]?.self, from: data)
                            
                            
                            objects = objects2
                            
                            completionHandler(objects,nil)
                            
                        }
                        else {
                            completionHandler(objects,APIError.invalidData)
                        }
                        
                        
                    } catch let jsonError {
                        print(jsonError)
                        completionHandler(objects,APIError.jsonParsingFailure)
                    }
                    }
                } else if response.statusCode == 404 {
                    completionHandler(nil,APIError.responseUnsuccessful)
                }
                
                
//                    completionHandler(objects,nil)
                
            }
            
            task.resume()
    }
    
    class func fetchObject<T>(apiURL:APIURL,completionHandler:@escaping (_ object:T?, _ error:APIError?)->Void) where T:Decodable  {
        
        print(T.Type.self)
        
        APIManager.apiURLSelected = apiURL
        
        print(apiURL)
        
        var object:T?
        
        //        guard let user = User.userDefault() else {
        //            return
        //        }
        
        
        
        //        let url = URL(string: "\(APIURL.SERVER)/\(APIURL.NOTIFICATIONS)/\(user.id)")
        
        //        let url = URL(string: "\(APIURL.SERVER.rawValue)/\(apiURL.rawValue)/\(user.id)")
        
        let url = URL(string:apiURL.url)
        
        var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0)
        
        //Autentificacion
        let loginData = NSString(format: "%@:%@", APICredentials.userName,APICredentials.password).data(using: String.Encoding.utf8.rawValue)!
        
        let base64LoginData = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        
        let device = 0
        request.setValue("\(device)", forHTTPHeaderField: "Device-Type")
        
        //            let post = NSString(format: "username=%@&password=%@", self.textMail.text!,self.textPassword.text!)
        //
        //            let data = post.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
        //
        //            let postLength = NSString(format: "%lu", (data?.count)!)
        //
        //            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        //
        //            request.httpBody = data
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                completionHandler(object,APIError.requestFailed)
                return
            }
            
            guard let response = response as? HTTPURLResponse
                else {
                    print ("server response error")
                    completionHandler(object,APIError.requestFailed)
                    return
            }
            
            print(response.statusCode)
            
            if response.statusCode == 200{
                do{
                    //                    print(data!)
                    //                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    //
                    //                    print(json)
                    //
                    //                    let dictionary = json as! [String : AnyObject]
                    //
                    //                    print(dictionary["functionname"]!)
                    
                    if let data = data {
                        let object2 = try JSONDecoder().decode(T?.self, from: data)
                        
                        //                        print(objects2?.count)
                        //
                        //                        print(objects?.count)
                        //
                        object = object2
                        //
                        //                        print(objects2?.count)
                        //
                        //                        print(objects?.count)
                    }
                    else {
                        completionHandler(object,APIError.invalidData)
                    }
                    
                    
                } catch let jsonError {
                    print(jsonError)
                    completionHandler(object,APIError.jsonParsingFailure)
                }
            }
            
            completionHandler(object,nil)
        }
        
        task.resume()
        
    }
    
    class func fetchObject<T>(apiURL:APIURL,parameters:[String:String],completionHandler:@escaping (_ object:T?, _ error:APIError?)->Void) where T:Decodable  {
        
        print(T.Type.self)
        
        APIManager.apiURLSelected = apiURL
        
        print(apiURL)
        
        var object:T?
        
        //        guard let user = User.userDefault() else {
        //            return
        //        }
        
        
        
        //        let url = URL(string: "\(APIURL.SERVER)/\(APIURL.NOTIFICATIONS)/\(user.id)")
        
        //        let url = URL(string: "\(APIURL.SERVER.rawValue)/\(apiURL.rawValue)/\(user.id)")
        
//        let url = URL(string:apiURL.url)
        
         let urlString = apiURL.url
        
//        var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0)
        
        var components = URLComponents(string: urlString)
        
            components?.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        
        
        var request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 0.0)
        
        //Autentificacion
//        let loginData = NSString(format: "%@:%@", APICredentials.userName,APICredentials.password).data(using: String.Encoding.utf8.rawValue)!
//
//        let base64LoginData = loginData.base64EncodedString()
//
//        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
//
        request.httpMethod = "GET"
//
//
//        let device = 0
//        request.setValue("\(device)", forHTTPHeaderField: "Device-Type")
        
        //            let post = NSString(format: "username=%@&password=%@", self.textMail.text!,self.textPassword.text!)
        //
        //            let data = post.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
        //
        //            let postLength = NSString(format: "%lu", (data?.count)!)
        //
        //            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        //
        //            request.httpBody = data
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                completionHandler(object,APIError.requestFailed)
                return
            }
            
            guard let response = response as? HTTPURLResponse
                else {
                    print ("server response error")
                    completionHandler(object,APIError.requestFailed)
                    return
            }
            
            print(response.statusCode)
            
            if response.statusCode == 200{
                DispatchQueue.main.async {
                                    do{
                                                            print(data!)
                                                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                                        
                                                            print(json)
                                        
                                        if urlString.contains("countries") {
                                                                                                let dictionary = json as! [[String : AnyObject]]
                                            
                                            print(dictionary)

                                        }
                                        
                                                            let dictionary = json as? [String : AnyObject]
                                        
//                                                            print(dictionary["functionname"]!)
                                        
                                        if let data = data {
                    //                        let object2 = try JSONDecoder().decode(T?.self, from: data)
                    //                        object = object2
                                            
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let context = appDelegate.persistentContainer.viewContext
                                            //                            let persistentContainer:NSPersistentContainer
                                                                        
                                            let decoder = JSONDecoder()
                                                                        
                                            guard let codingUserInfoManagedObjectContext = CodingUserInfoKey.managedObjectContext  else {
                                                                            fatalError("Failed to retrieve context")
                                                                            
                                            }
                                                                        
                                            decoder.userInfo[codingUserInfoManagedObjectContext] = context
                                                                        
                                            let object2 =  try decoder.decode(T?.self, from: data)
                                                                        
                                                                        
                                            //                            let objects2 = try JSONDecoder().decode([T]?.self, from: data)
                                                                        
                                                                        
                                                                        object = object2
                                            
                                            completionHandler(object,nil)
                                        }
                                        else {
                                            completionHandler(object,APIError.invalidData)
                                        }
                                        
                                        
                                    } catch let jsonError {
                                        print(jsonError)
                                        completionHandler(object,APIError.jsonParsingFailure)
                                    }
                    
//                    completionHandler(object,nil)

                }
                
            }
            
//            completionHandler(object,nil)
        }
        
        task.resume()
        
    }
    
    
    class func fetchObjects<T>(apiURL:APIURL, parameters:[String:String],completionHandler:@escaping (_ objects:[T]?, _ error:APIError?)->Void) where T:Decodable  {
            
            
                print(T.Type.self)
                
                APIManager.apiURLSelected = apiURL
                
                print(apiURL)
                
                var objects:[T]?
                
                //        guard let user = User.userDefault() else {
                //            return
                //        }
                
                
                
                //        let url = URL(string: "\(APIURL.SERVER)/\(APIURL.NOTIFICATIONS)/\(user.id)")
                
                //        let url = URL(string: "\(APIURL.SERVER.rawValue)/\(apiURL.rawValue)/\(user.id)")
                
                
            let urlString = apiURL.url
            
                
                
//                var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0)
        
        
        
            var components = URLComponents(string: urlString)
        
            components?.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        
        var request:URLRequest!
        if !apiURL.url.contains("entregasencursopanel") {
            request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 30.0)
        } else {
            request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)

        }
        
        
        
                
                //Autentificacion
                let loginData = NSString(format: "%@:%@", APICredentials.userName,APICredentials.password).data(using: String.Encoding.utf8.rawValue)!
                
                let base64LoginData = loginData.base64EncodedString()
                
                request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
                
                request.httpMethod = "GET"
                
                
                let device = 0
                request.setValue("\(device)", forHTTPHeaderField: "Device-Type")
                
                //            let post = NSString(format: "username=%@&password=%@", self.textMail.text!,self.textPassword.text!)
                //
                //            let data = post.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
                //
                //            let postLength = NSString(format: "%lu", (data?.count)!)
                //
                //            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                //
                //            request.httpBody = data
                
                
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        print(error)
                        DispatchQueue.main.async {
                            completionHandler(objects,APIError.requestFailed)
                            return
                        }
                    }
                    
                    guard let response = response as? HTTPURLResponse
                        else {
                            print ("server response error")
                            DispatchQueue.main.async {
                                completionHandler(objects,APIError.requestFailed)
                            }
                            
                            return
                    }
                    
                    print(response.statusCode)
                    
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                        print("Response data string:\(dataString)")
                                        
                    //                     var dataString2 =  dataString.replacingOccurrences(of: "null", with: "")
                                        
                                        
                                        
                                    }
                    
                    if response.statusCode == 200 {
                        
                        DispatchQueue.main.async {
                            
                        
                        
                        
                        do{
                            
                            
                            
                            
                            if let data = data {
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let context = appDelegate.persistentContainer.viewContext
    //                            let persistentContainer:NSPersistentContainer
                                
                                let decoder = JSONDecoder()
                                
                                guard let codingUserInfoManagedObjectContext = CodingUserInfoKey.managedObjectContext  else {
                                    fatalError("Failed to retrieve context")
                                    
                                }
                                
                                decoder.userInfo[codingUserInfoManagedObjectContext] = context
                                
                                let objects2 =  try decoder.decode([T].self, from: data)
                                
                                
    //                            let objects2 = try JSONDecoder().decode([T]?.self, from: data)
                                
                                
                                objects = objects2
                                
                                completionHandler(objects,nil)
                                
                            }
                            else {
                                if !apiURL.url.contains("validacionentrega") {
                                
                                    completionHandler(objects,APIError.invalidData)
                                } else {
                                    completionHandler(nil,nil)
                                }
                            }
                            
                            
                        } catch let jsonError {
                            print(jsonError)
                            
                            if !apiURL.url.contains("validacionentrega") {
                            
                                completionHandler(objects,APIError.jsonParsingFailure)
                            } else {
                                completionHandler(nil,nil)
                            }
                            
                            
                        }
                        }
                    } else if response.statusCode == 204 {
                        DispatchQueue.main.async {
                            let objects2 = [T]()
                            objects = objects2
                            
                            completionHandler(objects,nil)
                        }
                    } else if response.statusCode == 404 {
                        completionHandler(nil,APIError.responseUnsuccessful)
                    } else if response.statusCode == 412 {
                        completionHandler(nil,APIError.productDeliveryInmediatlyFound)
                    } else if response.statusCode == 417 {
                        completionHandler(nil,APIError.productDeliveryTo24HoursFound)
                    } else {
                        completionHandler(nil,APIError.invalidData)
                    }
                    
                    
    //                    completionHandler(objects,nil)
                    
                }
                
                task.resume()
        }
    
    static func getPostString(params:[String:Any]) -> String {
    //        var data = [String]()
            
    //        for (key,value) in params {
    //            data.append(key + "=\(value)")
    //        }
    //        return data.map { String (0) }.joined(separator: "&")
            
            
            let parameterArray = params.map { (key, value) -> String in
                return "\(key)=\(value)"
            }
            
            return parameterArray.joined(separator: "&")
        }
    
    
    class func processImageWithURL(url:String,completionHandler:@escaping (_ imageData:CGImage?)->Void) {
        let callerQueue = DispatchQueue.main
        let downloadQueue = DispatchQueue(label: "com.myapp.processimagequeue")
        
        downloadQueue.async {
            
            let src = CGImageSourceCreateWithURL(URL(string: url)! as CFURL , nil)
            
            let options = [kCGImageSourceCreateThumbnailWithTransform:true,kCGImageSourceCreateThumbnailFromImageAlways:true,kCGImageSourceThumbnailMaxPixelSize:640] as CFDictionary
            
            
            var thumbnail:CGImage? = nil
            
            if src != nil {
                thumbnail = CGImageSourceCreateThumbnailAtIndex(src!, 0, options)
            }
            
            callerQueue.async {
                completionHandler(thumbnail)
            }
        }
    }
    
    
    class func getRequestToken(completionHandler:@escaping (_ requestToken:RequestToken?,  _ errorApi:ErrorApi?) ->Void)  {
        
        var urlString = APIURL.REQUEST_TOKEN.url
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let params = ["api_key":"\(API_KEY)"]
        
        var components = URLComponents(string: urlString)
        
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request:URLRequest!
        
        request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "Error de conexión"
                    
                    completionHandler(nil,errorApi)
                    return
                }
            }
            
            guard let response = response as? HTTPURLResponse
            else {
                print ("server response error")
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "server response error"
                    completionHandler(nil,errorApi)
                }
                
                return
            }
            
//            print(response.statusCode)
            
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\(dataString)")
//
//                //                     var dataString2 =  dataString.replacingOccurrences(of: "null", with: "")
//
//            }
            
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        if response.statusCode == 200 {
                            let requestToken = try JSONDecoder().decode(RequestToken?.self, from: data)
                            
                            completionHandler(requestToken, nil)
                        } else {
                            let errorApi = try JSONDecoder().decode(ErrorApi?.self, from: data)
                            completionHandler(nil, errorApi)
                        }
                    }
                } catch  {
                    print(error)
                    
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "fallo en la conversión"
                    
                    completionHandler(nil,errorApi)
                                        
                }
            }
            
        }
        
        task.resume()
    }
    
    class func validateToken(withLogin login:Login, completionHandler:@escaping (_ requestToken:RequestToken?,  _ errorApi:ErrorApi?) ->Void)  {
        
        var urlString = APIURL.LOGIN.url
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let params = ["api_key":"\(API_KEY)"]
        
        var components = URLComponents(string: urlString)
        
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request:URLRequest!
        
        request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)
        
        request.httpMethod = "POST"
        
        let jsonData = try? JSONEncoder().encode(login)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "Error de conexión"
                    
                    completionHandler(nil,errorApi)
                    return
                }
            }
            
            guard let response = response as? HTTPURLResponse
            else {
                print ("server response error")
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "server response error"
                    completionHandler(nil,errorApi)
                }
                
                return
            }
            
            
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        if response.statusCode == 200 {
                            let requestToken = try JSONDecoder().decode(RequestToken?.self, from: data)
                            
                            completionHandler(requestToken, nil)
                        } else {
                            let errorApi = try JSONDecoder().decode(ErrorApi?.self, from: data)
                            completionHandler(nil, errorApi)
                        }
                    }
                } catch  {
                    print(error)
                    
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "fallo en la conversión"
                    
                    completionHandler(nil,errorApi)
                                        
                }
            }
            
        }
        
        task.resume()
    }
    
    class func createSession(withRequestToken token:String, completionHandler:@escaping (_ session:Session?,  _ errorApi:ErrorApi?) ->Void)  {
        
        var urlString = APIURL.SESSION.url
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let params = ["api_key":"\(API_KEY)"]
        
        var components = URLComponents(string: urlString)
        
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request:URLRequest!
        
        request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)
        
        request.httpMethod = "POST"
        
        let jsonObject = ["request_token": token]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "Error de conexión"
                    
                    completionHandler(nil,errorApi)
                    return
                }
            }
            
            guard let response = response as? HTTPURLResponse
            else {
                print ("server response error")
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "server response error"
                    completionHandler(nil,errorApi)
                }
                
                return
            }
            
            
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        if response.statusCode == 200 {
                            let session = try JSONDecoder().decode(Session?.self, from: data)
                            APIManager.session = session
                            completionHandler(session, nil)
                        } else {
                            let errorApi = try JSONDecoder().decode(ErrorApi?.self, from: data)
                            completionHandler(nil, errorApi)
                        }
                    }
                } catch  {
                    print(error)
                    
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "fallo en la conversión"
                    
                    completionHandler(nil,errorApi)
                                        
                }
            }
            
        }
        
        task.resume()
    }
    
    class func deleteSession(completionHandler:@escaping (_ response:Bool?,  _ errorApi:ErrorApi?) ->Void)  {
        var urlString = APIURL.DELETE_SESSION.url
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let params = ["api_key":"\(API_KEY)", "session_id":"\(APIManager.session?.session_id ?? "")"]
        
        var components = URLComponents(string: urlString)
        
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request:URLRequest!
        
        request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)
        
        request.httpMethod = "DELETE"
        
        let jsonObject = ["session_id": APIManager.session?.session_id]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "Error de conexión"
                    
                    completionHandler(nil,errorApi)
                    return
                }
            }
            
            guard let response = response as? HTTPURLResponse
            else {
                print ("server response error")
                DispatchQueue.main.async {
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "server response error"
                    completionHandler(nil,errorApi)
                }
                
                return
            }
            
            
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        if response.statusCode == 200 {
                            
                            completionHandler(true, nil)
                        } else {
                            let errorApi = try JSONDecoder().decode(ErrorApi?.self, from: data)
                            completionHandler(nil, errorApi)
                        }
                    }
                } catch  {
                    print(error)
                    
                    var errorApi = ErrorApi()
                    errorApi.success = false
                    errorApi.status_code = 0
                    errorApi.status_message = "fallo en la conversión"
                    
                    completionHandler(nil,errorApi)
                                        
                }
            }
            
        }
        
        task.resume()
    }
        
}


func getCountries(apiURL:APIURL,parameters:[String:String],completionHandler:@escaping (_ objects: [[String : String]]?, _ error: APIError?)->Void)   {
    
    
    APIManager.apiURLSelected = apiURL
    
    print(apiURL)
    
    
    let urlString = apiURL.url
    
    
    var components = URLComponents(string: urlString)
    
    components?.queryItems = parameters.map { (key, value) in
        URLQueryItem(name: key, value: value)
    }
    
    
    var request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 0.0)
    
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
            print(error)
            completionHandler(nil,APIError.requestFailed)
            return
        }
        
        guard let response = response as? HTTPURLResponse
        else {
            print ("server response error")
            completionHandler(nil,APIError.requestFailed)
            return
        }
        
        
        if response.statusCode == 200{
            DispatchQueue.main.async {
                do{
                    print(data!)
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    print(json)
                    
                    
                    let dictionary = json as? [[String : String]]
                    
                    print(dictionary)
                    
                    
                    
                    completionHandler(dictionary,nil)
                    
                    
                    
                    
                } catch let jsonError {
                    print(jsonError)
                    completionHandler(nil,APIError.jsonParsingFailure)
                }
                
                //                    completionHandler(object,nil)
                
            }
            
        }
        
        //            completionHandler(object,nil)
    }
    
    task.resume()

}
