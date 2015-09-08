//
//  ViewController.swift
//  Persistence
//
//  Created by Tim Greenough on 8/09/2015.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields : [UITextField]!
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectoryPath = paths[0] as! NSString
        return documentsDirectoryPath.stringByAppendingPathComponent("data.plist") as String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = self.dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            let array = NSArray(contentsOfFile: filePath) as! [String]
            for var i = 0; i < array.count; i++ {
                lineFields[i].text = array[i]
            }
            
            let app = UIApplication.sharedApplication()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
        }
        
        func applicationWillResignActive(notification : NSNotification) {
            let filePath = self.dataFilePath()
            let array = (self.lineFields as NSArray).valueForKey("text") as! NSArray
            array.writeToFile(filePath, atomically: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

