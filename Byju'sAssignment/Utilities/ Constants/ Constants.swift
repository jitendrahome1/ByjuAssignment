//
//   Constants.swift
//  ByjuAssignment
//
//  Created by Jitendra Kumar Agarwal on 02/08/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import Foundation

import Foundation
import UIKit

let kNewsHeadLineDetails = "NewsHeadLineDetails"
// MARK: Storyboard
let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

// NSDefult
func SET_OBJ_FOR_KEY(_ obj: AnyObject, key: String) {
    UserDefaults.standard.set(obj, forKey: key)
    UserDefaults.standard.synchronize()
}

func OBJ_FOR_KEY(_ key: String) -> AnyObject? {
    if UserDefaults.standard.object(forKey: key) != nil {
        return UserDefaults.standard.object(forKey: key)! as AnyObject?
    }
    return nil
}



func SET_INTEGER_FOR_KEY(_ integer: Int, key: String) {
    UserDefaults.standard.set(integer, forKey: key)
}

func INTEGER_FOR_KEY(_ key: String) -> Int? {
    return UserDefaults.standard.integer(forKey: key)
}

func SET_FLOAT_FOR_KEY(_ float: Float, key: String) {
    UserDefaults.standard.set(float, forKey: key)
}

func FLOAT_FOR_KEY(_ key: String) -> Float? {
    return UserDefaults.standard.float(forKey: key)
}

func SET_BOOL_FOR_KEY(_ bool: Bool, key: String) {
    UserDefaults.standard.set(bool, forKey: key)
}

func BOOL_FOR_KEY(_ key: String) -> Bool? {
    return UserDefaults.standard.bool(forKey: key)
}

func REMOVE_OBJ_FOR_KEY(_ key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}
