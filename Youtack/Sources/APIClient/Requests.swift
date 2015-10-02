//
//  Requests.swift
//  Youtack
//
//  Created by Yarik Smirnov on 26/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Alamofire
import Mantle
import XMLReader_Arc

extension Request {
    
    public static func XMLResponseSerializer(
        options options: XMLReaderOptions = 0)
        -> GenericResponseSerializer<AnyObject>
    {
        return GenericResponseSerializer { _, response, data in
            guard let validData = data else {
                let error = Utils.error("XML parsing failed. Data is malformed")
                return .Failure(data, error)
            }
            if let httpResponse = response {
                Log.debug(httpResponse.debugDescription)
            }
            do {
                let XML = try XMLReader.dictionaryForXMLData(validData, options: options)
                Log.verbose((XML as NSDictionary).debugDescription)
                if XML.count == 1 {
                    if let nestedEntry = XML.values.first {
                        return .Success(nestedEntry)
                    }
                }
                return .Success(XML)
            } catch {
                return .Failure(data, error as NSError)
            }
        }
    }
    
    public func responseXML(
        options options: XMLReaderOptions = 0,
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void)
        -> Self
    {
        Log.debug(request.debugDescription)
        return response(
            responseSerializer: Request.XMLResponseSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

extension Request {
    
    public func responseObject<T: MTLJSONSerializing>(
        completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<T>) -> Void
        ) -> Self
    {
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

