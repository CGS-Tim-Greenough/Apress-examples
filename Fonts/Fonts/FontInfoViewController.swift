//
//  FontInfoViewController.swift
//  Fonts
//
//  Created by Tim Greenough on 1/09/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {

    var font : UIFont!
    var favourite : Bool = false
    @IBOutlet weak var fontSampleLabel : UILabel!
    @IBOutlet weak var fontSizeSlider : UISlider!
    @IBOutlet weak var fontSizeLabel : UILabel!
    @IBOutlet weak var favouriteSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontSampleLabel.font = font
        fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLabel.text = "\(Int(font.pointSize))"
        favouriteSwitch.on = favourite
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func slideFontSize(slider : UISlider) {
        let newSize = roundf(slider.value)
        fontSampleLabel.font = font.fontWithSize(CGFloat(newSize))
        fontSizeLabel.text = "\(Int(newSize))"
    }
    
    @IBAction func toggleFavourite(sender : UISwitch) {
        let favouritesList = FavouritesList.sharedFavouriteList
        if sender.on {
            favouritesList.addFavourite(font.fontName)
        } else {
            favouritesList.removeFavourite(font.fontName)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
