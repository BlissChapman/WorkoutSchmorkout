//
//  main.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreLocation

print("Welcome to the Workout Logger!  Select an option below:\n")

var headOfList: Workout? = Utilities.add5TestWorkouts()

while true {
    switch Menu.retrieveSelectedOption() {
    case .Add:
        let userLocation = Utilities.retrieveUserLocation()
        
        print("If you exercised with a buddy, enter their name. Otherwise hit enter to continue.")
        let buddy: String? = Console.readln()
        
        print("hit return to start workout:")
        Console.readln()
        let startTime = NSDate()
        
        print("hit return to end workout:")
        Console.readln()
        let elapsedTime = NSDate().timeIntervalSinceDate(startTime)
        
        let rating = Utilities.retrieveUserRating()
        
        //add new workout to the end of the linked list
        if headOfList == nil {
            let newWorkout = Workout(startTime: startTime, duration: elapsedTime, location: userLocation, buddy: buddy, rating: rating, id: 1, next: nil)
            headOfList = newWorkout
        } else {
            headOfList!.append(startTime, duration: elapsedTime, location: userLocation, buddy: buddy, rating: rating, id: headOfList!.countWorkouts() + 1)
        }
        
        continue
        
    case .Remove:
        guard let head = headOfList else {
            print("You have not recorded any workouts yet.\n")
            continue
        }
        print(head.listDescription())
        print("Type the number of the workout record listed above that you would like to remove:")
        
        guard let userInput = Console.readln() else {
            print("COULD NOT INTERPRET INPUT. Please select an option from the menu below:")
            continue
        }
        guard let selectedID = Int(userInput) where selectedID > 0 && selectedID <= head.countWorkouts() else {
            print("That id is outside the range of your workout list.")
            continue
        }
        
        headOfList = head.removeWorkout(selectedID)
        continue
        
    case .DisplayAll:
        guard let headOfList = headOfList else {
            print("You have not recorded any workouts yet. \n")
            continue
        }
        
        print(headOfList.listDescription())
        continue
        
    case .DisplayWithBuddy: print("display with buddy")
    case .DisplayWithLocation: print("display with location")
    case .PersonalBestForLocation: print("PersonalBestForLocation")
    case .Quit:
        
        print("Are you sure you want to quit (yes or no)? - all your data will be lost.")
        guard let userInput = Console.readln() else {
            print("COULD NOT INTERPRET INPUT. Please select an option from the menu below:")
            continue
        }
        
        if userInput.uppercaseString == "YES" {
            exit(EXIT_SUCCESS)
        } else {
            continue
        }
    }
}

