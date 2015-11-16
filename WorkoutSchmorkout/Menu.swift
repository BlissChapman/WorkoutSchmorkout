//
//  Menu.swift
//  WorkoutSchmorkout
//
//  Created by Bliss Chapman on 11/15/15.
//  Copyright © 2015 Bliss Chapman. All rights reserved.
//

import Foundation

public enum MenuOption: Int {
    case Add = 1
    case Remove = 2
    case DisplayAll = 3
    case DisplayWithBuddy = 4
    case DisplayWithLocation = 5
    case PersonalBestForLocation = 7
    case Quit = 8
}

final class Menu {
    
    static func retrieveSelectedOption() -> MenuOption {
        while true {
            printOptions()
            
            guard let userInput = Console.readln() else {
                print("COULD NOT INTERPRET INPUT. Please select an option from the menu below:")
                continue
            }
            
            guard let selectionCode = Int(userInput) where selectionCode > 0 && selectionCode < 9 else {
                print("INVALID INPUT (0). Please select an option from the list below:")
                continue
            }
            
            guard let selectedOption = MenuOption(rawValue: selectionCode) else {
                print("INVALID INPUT (1). Please select an option from the list below:")
                continue
            }
            
            return selectedOption
        }
    }
    
    private static func printOptions() {
        print(" 1) add a workout")
        print(" 2) remove a workout")
        print(" 3) display all workouts (listing should start with most recent)")
        print(" 4) display all workouts with buddy")
        print(" 5) display workouts for a certain location (listing should be \n    ordered by rating - best rated workout to lowest rated \n    workout)")
        print(" 7) PB: display personal best time for a prompted location")
        print(" 8) quit\n")
        print("Select an option above:")
    }
}
