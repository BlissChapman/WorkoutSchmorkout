//
//  Utilities.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreLocation

class Console {
    
    //Please note that this is not my code but is roughly equivalent to the provided TextIO class.  It is taken from this stack overflow answer: http://stackoverflow.com/a/25042581
    static func readln(max:Int = 8192) -> String? {
        assert(max > 0, "max must be between 1 and Int.max")
        
        var buf:Array<CChar> = []
        var c = getchar()
        while c != EOF && c != 10 && buf.count < max {
            buf.append(CChar(c))
            c = getchar()
        }
        
        //always null terminate
        buf.append(CChar(0))
        
        return buf.withUnsafeBufferPointer { String.fromCString($0.baseAddress) }
    }
}

class Utilities {
    static func retrieveUserLocation() -> CLLocationCoordinate2D {
        print("Please enter your current location.")
        
        var lat: Double!
        while true {
            print("Latitude:")
            guard let latitude = (Console.readln() as? NSString)?.doubleValue where latitude != 0.0 && latitude >= -90.0 && latitude <= 90.0 else {
                print("INVALID LATITUDE\n")
                continue
            }
            
            lat = latitude
            break
        }
        
        var long: Double!
        while true {
            print("Longitude:")
            guard let longitude = (Console.readln() as? NSString)?.doubleValue where longitude != 0.0 && longitude >= -180.0 && longitude <= 180.0 else {
                print("INVALID LONGITUDE\n")
                continue
            }
            long = longitude
            break
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    
    static func retrieveUserRating() -> Int {
        while true {
            print("Provide a rating to workout (1: great; 10 poor):")
            
            guard let userInput = Console.readln() else {
                print("COULD NOT INTERPRET INPUT.")
                continue
            }
            
            guard let rating = Int(userInput) where rating > 0 && rating <= 10 else {
                print("INVALID RATING.")
                continue
            }
            
            return rating
        }
    }
}