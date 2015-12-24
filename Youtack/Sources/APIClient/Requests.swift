//
//  Requests.swift
//  Youtack
//
//  Created by Yarik Smirnov on 26/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Mantle
import XMLDictionary

extension Dictionary {
    func removeRoot() -> AnyObject {
        if count == 1 {
             let nestedEntry = values.first as! AnyObject
            if let nestedDict = nestedEntry as? Dictionary {
                return nestedDict.removeRoot()
            } else {
                return nestedEntry
            }
        }
        return self as! AnyObject
    }
}

extension Request {
    
    public static func XMLResponseSerializer()
        -> GenericResponseSerializer<AnyObject>
    {
        return GenericResponseSerializer { _, response, data in
            guard let validData = data else {
                let error = Utils.error("XML parsing failed. Data is malformed")
                return .Failure(data, error)
            }
            if let httpResponse = response {
                Log.debug("\(httpResponse.URL!) \(httpResponse.statusCode)\nHeaders: \(httpResponse.allHeaderFields as NSDictionary)")
            }
            guard let XML = NSDictionary(XMLData: validData) as? [String: AnyObject] else {
                let error = Utils.error("XMLDictionary failed to return valid dictionary.")
                return .Failure(data, error)
            }
            Log.verbose((XML as NSDictionary).debugDescription)
            let result = XML.removeRoot()
            return .Success(result)
        }
    }
    
    public func responseXML(
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void)
        -> Self
    {
        Log.debug((self as! CustomStringConvertible).description)
        return response(
            responseSerializer: Request.XMLResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}

extension Request {
    
    func responseError(completionHandler: (NSError?) -> Void) -> Self {
        Log.debug((self as! CustomStringConvertible).description)
        return response(responseSerializer: Request.stringResponseSerializer() ) { request, response, result in
            switch result {
            case .Success(_):
                break
            case .Failure(let data, let error as NSError):
                let xmlReader = XMLDictionaryParser()
                xmlReader.attributesMode = .Unprefixed
                xmlReader.nodeNameMode = .Never
                xmlReader.wrapRootNode = true
                guard let errorData = data,
                      let xml = xmlReader.dictionaryWithData(errorData),
                      let failureReason = xml["error"] as? String else {
                        completionHandler(error)
                        return
                }
                let error = Utils.error(failureReason)
                completionHandler(error)
            default:
                break
            }
        }
    }
    
    public func responseObject<T: MTLJSONSerializing>(
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<T>) -> Void
        ) -> Self
    {
        Log.debug((self as! CustomStringConvertible).description)
        let responseSerializer = GenericResponseSerializer<T> { request, response, data in
            let XMLResponseSerializer = Request.XMLResponseSerializer()
            let result = XMLResponseSerializer.serializeResponse(request, response, data)
            
            switch result {
            case .Success(let value):
                guard let dictionary = value as? [NSObject: AnyObject!] else {
                    let error = Utils.error("Mapping failed. JSON is malformed")
                    return .Failure(data, error)
                }
                do {
                    let object = try MTLJSONAdapter.modelOfClass(T.self, fromJSONDictionary: dictionary)
                    return .Success(object as! T)
                } catch (let error) {
                    return .Failure(data, error)
                }
            case .Failure(let data, let error):
                return .Failure(data, error)
            }
        }
        return response(
            responseSerializer: responseSerializer,
            completionHandler: completionHandler
        )
    }
    
    public func responseArray<T: MTLJSONSerializing>(
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<[T]>) -> Void
        ) -> Self
    {
        Log.debug((self as! CustomStringConvertible).description)
        let responseSerializer = GenericResponseSerializer<[T]> { request, response, data in
            let XMLResponseSerializer = Request.XMLResponseSerializer()
            let result = XMLResponseSerializer.serializeResponse(request, response, data)
            
            switch result {
            case .Success(let value):
                guard let array = value as? [AnyObject] else {
                    let error = Utils.error("Mapping failed. XML is malformed")
                    return .Failure(data, error)
                }
                do {
                    Log.verbose((array[0] as! NSDictionary).description)
                    let object = try MTLJSONAdapter.modelsOfClass(T.self, fromJSONArray: array)
                    return .Success(object as! [T])
                } catch (let error) {
                    return .Failure(data, error)
                }
            case .Failure(let data, let error):
                return .Failure(data, error)
            }
        }
        return response(
            responseSerializer: responseSerializer,
            completionHandler: completionHandler
        )
    }
    
}

