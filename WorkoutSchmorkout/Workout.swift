//
//  Workout.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreLocation

class Workout {
    
    var next: Workout?
    
    private(set) var startTime: NSDate
    private(set) var duration: NSTimeInterval
    private(set) var location: CLLocationCoordinate2D
    private(set) var buddy: String?
    private(set) var rating: Int
    
    init(startTime: NSDate, duration: NSTimeInterval, location: CLLocationCoordinate2D, buddy: String?, rating: Int, next: Workout?) {
        
        self.startTime = startTime
        self.duration = duration
        self.location = location
        self.buddy = buddy
        self.rating = rating
    }

    private func toString() -> String {
        return "\n Location: (latitude: \(location.latitude), longitude: \(location.longitude)) \n Buddy: \(buddy ?? "no partner") \n Start Date: \(startTime) \n Duration: \(duration) \n Rating: \(rating)"
    }
    
    /**
     Creates a new Workout entry at the end of the workouts list. Recursively finds the last entry then adds a new link to the end.
    */
    func append(startTime: NSDate, duration: NSTimeInterval, location: CLLocationCoordinate2D, buddy: String?, rating: Int) {
        if next == nil {
            next = Workout(startTime: startTime, duration: duration, location: location, buddy: buddy, rating: rating, next: nil)
        } else {
            next?.append(startTime, duration: duration, location: location, buddy: buddy, rating: rating)
        }
    }
    
    /**
     the current workout list will be displayed in order from the most recent workout to the oldest workout. The list will be numbered with consecutive numbers and the location, workout buddy (if any), start date and time, workout duration and workout rating will be displayed.
    */
    func listDescription(counter: Int = 1) -> String {
        let currentWorkoutDescription = "WORKOUT \(counter): " + toString()
        if next == nil {
            return currentWorkoutDescription
        }
        
        return "\n" + next!.listDescription(counter + 1)  + "\n\n" + currentWorkoutDescription + "\n"
    }
}