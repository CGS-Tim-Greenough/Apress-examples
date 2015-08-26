//
//  RootViewController.swift
//  Fonts
//
//  Created by Tim Greenough on 25/08/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favouritesList: FavouritesList!
    private let familyCell = "FamilyName"
    private let favouritesCell = "Favorites"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // ! added after error
        familyNames = sorted(UIFont.familyNames() as! [String])
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        favouritesList = FavouritesList.sharedFavouriteList
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return favouritesList.favourites.isEmpty ? 1 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                // The font names list
                // ! added after error
                let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath : indexPath) as! UITableViewCell
                // ! added after error
                cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
                // ! added after error
                cell.textLabel!.text = familyNames[indexPath.row]
                cell.detailTextLabel?.text = familyNames[indexPath.row]
                return cell
            } else {
                // The favourites list
                // ! added after error
                return tableView.dequeueReusableCellWithIdentifier(favouritesCell, forIndexPath : indexPath) as! UITableViewCell
        }
    }
    
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath : NSIndexPath) -> UIFont? {
            if indexPath.section == 0 {
                let familyName = familyNames[indexPath.row]
                // ! added after error
                let fontName = UIFont.fontNamesForFamilyName(familyName).first as! String
                return UIFont(name: fontName, size: cellPointSize)
            } else {
                return nil
            }
    }

}
