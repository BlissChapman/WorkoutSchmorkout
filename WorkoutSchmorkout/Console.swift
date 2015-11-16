//
//  Console.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation

class Console {
    
    static func readln() -> String? {
        let inputData = NSFileHandle.fileHandleWithStandardInput().availableData
        let rawInput = NSString(data: inputData, encoding:NSUTF8StringEncoding) as? String
        //remove the new line character
        let input = rawInput?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        return input
    }
}