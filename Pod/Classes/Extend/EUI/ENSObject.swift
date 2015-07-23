//
//  ENSObject.swift
//  Pods
//
//  Created by zhuchao on 15/7/21.
//
//

import Foundation
import JavaScriptCore

@objc public protocol ENSObject:JSExport{
    func val(keyPath:String) -> AnyObject?
    func attr(keyPath:String,_ value:AnyObject?)
    func attrs(dict:[NSObject : AnyObject]!)
}

public extension NSObject{
    
    public func attr(key:String,_ value:AnyObject?) {
        SwiftTryCatch.try({
            if let str = value as? String {
                self.setValue(str.anyValue(key.toKeyPath), forKeyPath: key.toKeyPath)
            }else{
                self.setValue(value, forKeyPath: key.toKeyPath)
            }
        }, catch: { (error) in
            println("JS Error:\(error.description)")
        }, finally: nil)
    }
    
    public func attrs(dict:[NSObject : AnyObject]!){
        SwiftTryCatch.try({
            self.setValuesForKeysWithDictionary(dict)
        }, catch: { (error) in
            println("JS Error:\(error.description)")
        }, finally: nil)
    }
    
    public func val(key:String) -> AnyObject? {
        var result:AnyObject?
        SwiftTryCatch.try({
            result = self.valueForKeyPath(key.toKeyPath)
            }, catch: { (error) in
                println("JS Error:\(error.description)")
            }, finally: nil)
        return result
    }
}

@objc public protocol EZActionJSExport:JSExport{
    static func SEND_IQ_CACHE (req:EZRequest)
    static func SEND_CACHE (req:EZRequest)
    static func SEND (req:EZRequest)
    static func Upload (req:EZRequest)
    static func Download (req:EZRequest)
}