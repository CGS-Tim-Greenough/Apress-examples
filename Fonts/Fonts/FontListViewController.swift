//
//  FontListViewController.swift
//  Fonts
//
//  Created by Tim Greenough on 26/08/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fontNames : [String] = []
    var showsFavourites = false
    private var cellPointSize : CGFloat!
    private let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        
        if showsFavourites {
            navigationItem.rightBarButtonItem = editButtonItem()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fontForDisplay(atIndexPath indexPath : NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fontNames.count
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if showsFavourites {
            fontNames = FavouritesList.sharedFavouriteList.favourites
            
            tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        // ! added after error
        cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
        // ! added after error
        cell.textLabel!.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavourites
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !showsFavourites {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            let favourite = fontNames[indexPath.row]
            FavouritesList.sharedFavouriteList.removeFavourite(favourite)
            fontNames = FavouritesList.sharedFavouriteList.favourites
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        FavouritesList.sharedFavouriteList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavouritesList.sharedFavouriteList.favourites
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC = segue.destinationViewController as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.font = font
            infoVC.favourite = contains(FavouritesList.sharedFavouriteList.favourites, font.fontName)
        }
    }
    
}
