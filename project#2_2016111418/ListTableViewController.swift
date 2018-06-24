//
//  ListTableViewController.swift
//  Today's cactus
//
//  Created by SWUCOMPUTER on 2018. 5. 29..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    var days: [NSManagedObject]=[]
   // var fetchedArray: [DaysData] = Array()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "main_background.png")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Days")
        let sortDescriptor = NSSortDescriptor (key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            days = try context.fetch(fetchRequest)
        } catch _ as NSError {
            print("Could not fetch.  (error),  (error.userInfo)") }
        
        self.tableView.reloadData() }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Cell", for: indexPath)

        let day = days[indexPath.row]
        var display: String = ""
        if let nameLabel = day.value(forKey: "title") as? String {
            display = nameLabel }
//        if let memoLabel = day.value(forKey: "memo") as? String {
//            display = display + " " + memoLabel }
        
        cell.textLabel?.text = display
        cell.detailTextLabel?.text = day.value(forKey: "memo") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {

                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailDays = days[selectedIndex]
                
            }
            }}}
//    }




   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            context.delete(days[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch _ as NSError {
                print("Could not delete  (error),  (error.userInfo)") }
            // 배열에서 해당 자료 삭제
            days.remove(at: indexPath.row)
            // 테이블뷰 Cell 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
        }}
   


}
