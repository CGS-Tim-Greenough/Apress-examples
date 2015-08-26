//
//  FavouritesList.swift
//  Fonts
//
//  Created by Tim Greenough on 25/08/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import Foundation
import UIKit

class FavouritesList {
    class var sharedFavouriteList : FavouritesList {
        struct Singleton {
            static let instance = FavouritesList()
        }
        return Singleton.instance
    }
    // "The private(set) qualifier means that the array can be read by code outside the class, but only code in the class implementation can modify it. That’s exactly what we want, because we need users of our class to be able to read the favorites list" - textbook
    private(set) var favourites:[String]
    
    // Set the initial content of the favourites array
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavourites = defaults.objectForKey("favourites") as? [String]
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    func addFavourite(fontName : String) {
        if (!contains(favourites, fontName)) {
            favourites.append(fontName)
            saveFavourites()
        }
    }
    
    func removeFavourite(fontName : String) {
        if let index = find(favourites, fontName) {
            favourites.removeAtIndex(index)
            saveFavourites()
        }
    }
    
    private func saveFavourites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favourites, forKey: "favourites")
        defaults.synchronize()
    }
}