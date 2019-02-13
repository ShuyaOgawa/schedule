//
//  Ex.swift
//  Schedule2
//
//  Created by 小川秀哉 on 2019/02/13.
//  Copyright © 2019年 Digital Circus Inc. All rights reserved.
//

import Foundation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit


// global
var globalValue1:String = "global 1"
var globalValue2:String = "global 2"

class Ex {
    
    // static
    static var staticValue1:String = "static 1"
    static var staticValue2:String = "static 2"
    
    // class
    class var user_id:String {
        var user_id = ""
        if UserDefaults.standard.object(forKey: "user_id") != nil {
            user_id = UserDefaults.standard.string(forKey: "user_id")!
        }
        return user_id
    }
    
    class var class_array:Array<Any> {
        var class_array: Array = ["",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "",     "", ""]
        if UserDefaults.standard.object(forKey: "class_array") != nil {
            class_array = UserDefaults.standard.array(forKey: "class_array") as! [String]
        }
        return class_array
    }
}
