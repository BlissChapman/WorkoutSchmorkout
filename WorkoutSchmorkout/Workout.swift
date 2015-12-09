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
    private(set) var location: String//CLLocationCoordinate2D
    private(set) var buddy: String?
    private(set) var rating: Int
    private(set) var id: Int
    private(set) var description: String
    
    init(startTime: NSDate, duration: NSTimeInterval, location: String, buddy: String?, rating: Int, id: Int, next: Workout?) {
        
        self.startTime = startTime
        self.duration = duration
        self.location = location
        self.buddy = buddy
        self.rating = rating
        self.next = next
        self.id = id
        
        self.description  = { () -> String in
            let buddyText = (buddy?.characters.count > 0) ? buddy : "none"
            let workoutContentDescription =  "\n Location: \(location) \n Buddy: \(buddyText ?? "none") \n Start Date: \(startTime) \n Duration: \(duration) \n Rating: \(rating)"
            
            return "WORKOUT \(id): " + workoutContentDescription + "\n"
        }()
    }
    
    
    /**
     Creates a new Workout entry at the end of the workouts list. Recursively finds the last entry then adds a new link to the end.
     */
    func append(startTime: NSDate, duration: NSTimeInterval, location: String, buddy: String?, rating: Int, id: Int) {
        if next == nil {
            next = Workout(startTime: startTime, duration: duration, location: location, buddy: buddy, rating: rating, id: id, next: nil)
        } else {
            next?.append(startTime, duration: duration, location: location, buddy: buddy, rating: rating, id: id)
        }
    }
    
    /**
     Returns a description of the list formatted like this:
     WORKOUT 1:
     Location: (latitude: 12.0, longitude: 12.0)
     Buddy: Bliss
     Start Date: 2015-11-16 00:19:45 +0000
     Duration: 12.000045
     Rating: 1
     
     The list will be displayed in order from the most recent workout to the oldest workout.
     */
    func listDescription() -> String {
        if next == nil {
            return "\n" + self.description
        }
        
        return next!.listDescription()  + "\n\n" + self.description
    }
    
    /**
     Returns a description of all workouts with the given buddy name.  The list will be displayed in order from the most recent workout to the oldest workout.
     */
    func listDescriptionOfWorkouts(withBuddy name: String) -> String {
        if self.buddy?.uppercaseString == name.uppercaseString {
            if next == nil {
                return self.description
            } else {
                return next!.listDescriptionOfWorkouts(withBuddy: name)  + "\n\n" + self.description
            }
        } else {
            return (next == nil) ? "" : next!.listDescriptionOfWorkouts(withBuddy: name)
        }
    }
    
    /**
     Returns a description of all workouts for the provided location sorted from highest to lowest rating.
     */
    func listDescriptionOfWorkouts(withLocation location: String) -> String {
        if self.location.uppercaseString == location.uppercaseString {
            if next != nil {
                return findHeighestRatedWorkout().description + next!.listDescriptionOfWorkouts(withLocation: location)
            } else {
                return findHeighestRatedWorkout().description
            }
        } else {
            return (next == nil) ? "" : next!.listDescriptionOfWorkouts(withLocation: location)
        }
    }
    
    private func findHeighestRatedWorkout() -> Workout {
        guard next != nil else { return self }
        
        if self.rating >= next!.findHeighestRatedWorkout().rating {
            return self
        } else {
            return next!.findHeighestRatedWorkout()
        }
    }
    
    /**
     Display the personal best time for a prompted location.
    */
    func displayPersonalBestForLocation(withLocation location: String) -> NSTimeInterval? {
        if self.location.uppercaseString == location.uppercaseString {
            if next != nil {
                let bestInRestOfList = next!.displayPersonalBestForLocation(withLocation: location)
                if bestInRestOfList == nil || duration < bestInRestOfList {
                    return duration
                } else {
                    return bestInRestOfList
                }
            } else {
                return duration
            }
        } else {
            return (next == nil) ? nil : next!.displayPersonalBestForLocation(withLocation: location)
        }
    }
    
    
    /**
     Returns the total amount of workouts in the list.
     */
    func countWorkouts() -> Int {
        return (next == nil) ? 1 : 1 + next!.countWorkouts()
    }
    
    /**
     Removes the workout with the specified id if it exists and returns the head of the list.
     */
    func removeWorkout(withID id: Int) -> Workout? {
        let head = self
        
        //if the current item has the specified id (will only happen if the head is the workout to remove)
        guard head.id != id else {
            //if the head is the only item in the list, then return nil as the new head
            //otherwise return the next item
            return (next == nil) ? nil : next
        }
        
        //if we have made it through the whole list without finding an item with the specified id, then return the original head of the list
        if next == nil {
            print("No item in your list of workouts has the id: \(id)")
            return headOfList
        } else {
            //if the next item is the item to remove
            if next!.id == id {
                //change the current item's next value to whatever the next item's next value is
                self.next = next?.next
                return headOfList
            } else {
                //RECURSIVE CASE
                return next!.removeWorkout(withID: id)
            }
        }
    }
}