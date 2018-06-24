//
//  DetailViewController.swift
//  project#2_2016111418
//
//  Created by SWUCOMPUTER on 2018. 6. 13..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {
    @IBOutlet var textName: UILabel!
    @IBOutlet var textDate: UILabel!
    @IBOutlet var textDescription: UILabel!
    @IBOutlet var textImportant: UILabel!
    @IBOutlet var process: UISegmentedControl!
    var myimportant: Int?
    
    
    @IBAction func segPerfect(_ sender: UISegmentedControl) {
    
       myimportant=process.selectedSegmentIndex+1
 
    }
    var detailDays: NSManagedObject?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.view.backgroundColor = UIColor(patternImage: UIImage(named: "show_background.png")!)
  
//
        if let day = detailDays {
            textName.text = day.value(forKey: "title") as? String
            textDate.text = day.value(forKey: "date") as? String
            textDescription.text = day.value(forKey: "memo") as? String
            textImportant.text=day.value(forKey: "important") as? String
        
        }
        
       
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toStoreMain"{
            let destination = segue.destination as! MyCactusViewController
            
            let myinf: Int!=myimportant
            destination.myinfo=myinf
        }
    }

    
   
    

}

