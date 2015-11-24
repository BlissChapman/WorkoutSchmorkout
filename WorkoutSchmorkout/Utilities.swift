//
//  Utilities.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreLocation

class Utilities {
    
    static func retrieveUserLocation() -> String {
        while true {
            print("Please enter your current location:")

            guard let location = Console.readln() where location.characters.count >= 2  else {
                print("INVALID LOCATION\n")
                continue
            }
            
            return location
        }
    }

    
    //Location with lat and long:
//    static func retrieveUserLocation() -> CLLocationCoordinate2D {
//        print("Please enter your current location.")
//        
//        var lat: Double!
//        while true {
//            print("Latitude:")
//            guard let latitude = (Console.readln() as? NSString)?.doubleValue where latitude != 0.0 && latitude >= -90.0 && latitude <= 90.0 else {
//                print("INVALID LATITUDE\n")
//                continue
//            }
//            
//            lat = latitude
//            break
//        }
//        
//        var long: Double!
//        while true {
//            print("Longitude:")
//            guard let longitude = (Console.readln() as? NSString)?.doubleValue where longitude != 0.0 && longitude >= -180.0 && longitude <= 180.0 else {
//                print("INVALID LONGITUDE\n")
//                continue
//            }
//            long = longitude
//            break
//        }
//        
//        return CLLocationCoordinate2D(latitude: lat, longitude: long)
//    }
    
    
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
    
    /**
     Adds 5 starting workouts and returns the head of this list. This is for debugging purposes only
     */
    static func add5TestWorkouts() -> Workout {
        let workout1 = Workout(startTime: NSDate(), duration: 5.0, location: "TEST LOCATION", buddy: "Test Workout", rating: 1, id: 5, next: nil)
        let workout2 = Workout(startTime: NSDate(), duration: 5.0, location: "TEST LOCATION", buddy: "Test Workout", rating: 6, id: 4, next: workout1)
        let workout3 = Workout(startTime: NSDate(), duration: 5.0, location: "TEST LOCATION", buddy: "Test Workout", rating: 3, id: 3, next: workout2)
        let workout4 = Workout(startTime: NSDate(), duration: 5.0, location: "TEST LOCATION", buddy: "Test Workout", rating: 4, id: 2, next: workout3)
        let head = Workout(startTime: NSDate(), duration: 5.0, location: "TEST LOCATION", buddy: "HEAD", rating: 5, id: 9, next: workout4)
        
        return head
    }
}