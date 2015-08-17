//
//  ViewController.swift
//  Sections
//
//  Created by Tim Greenough on 17/08/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names : [String : [String]]!
    var keys : [String]!
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the default table view cell class that should be displayed for each row
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        
        let path = NSBundle.mainBundle().pathForResource("sortednames", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        // 'as' replaced with 'as!' due to error
        names = namesDict as! [String : [String]]
        keys = sorted(namesDict!.allKeys as! [String])
    }
    
    // MARK: Table View Data Source methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        // 'textLabel' replaced wth 'textLabel!' due to error
        cell.textLabel!.text = nameSection[indexPath.row]
        
        return cell
    }
    
    // Can there be more items in the index that there are sections?
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return keys
    }


}

