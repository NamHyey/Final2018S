//
//  InsertViewController.swift
//  project#2_2016111418
//
//  Created by SWUCOMPUTER on 2018. 6. 13..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
class InsertViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate{
    
   @IBOutlet var importantCheck: UISlider!
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var pickerDateTime: UIDatePicker!
    @IBOutlet var alarmPickerDate: UIDatePicker!
    @IBOutlet var alarmView: UIView!
    @IBOutlet var textDescription: UITextView!

    var alarmOnoff: Bool?
//    var editOnoff: Bool?
//    var fillContent: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmView.isHidden=true
        alarmOnoff=false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "insert_background.png")!)
        
//        if let myedit=editOnoff{
//            fillContent=myedit
//        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
     //   textDescription.becomeFirstResponder()
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    @IBAction func saveButton() {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Days", in: context)

                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
        let myDate = dateFormatter.string(from: self.pickerDateTime.date)
        
        
                let alarmDateFormatter = DateFormatter()
                alarmDateFormatter.dateStyle = .medium
                alarmDateFormatter.timeStyle = .medium
                let alarm = alarmDateFormatter.string(from: self.alarmPickerDate.date)
        let dayImportanat = importantCheck.value*100
       
        let importantGress: String
        if(dayImportanat>=0&&dayImportanat<20){
            importantGress="💜🖤🖤🖤🖤"
        }else if(dayImportanat>=20&&dayImportanat<40){
            importantGress="💜💜🖤🖤🖤"
        }else if(dayImportanat>=40&&dayImportanat<60){
            importantGress="💜💜💜🖤🖤"
        }else if(dayImportanat>=60&&dayImportanat<80){
            importantGress="💜💜💜💜🖤"
        }else{
            importantGress="💜💜💜💜💜"
        }
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(textDescription.text, forKey: "memo")
        object.setValue(myDate, forKey: "date")
        object.setValue(alarm, forKey: "alarmDate")
        object.setValue(importantGress, forKey: "important")
        do {
            try context.save()
            print("saved!")
        } catch _ as NSError {
            print("Could not save  (error),  (error.userInfo)") }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
        
      
        
        
    
        
        
        
        
        
    }

    
    
    

    
    
    @IBAction func showAlarm(_ sender: Any) {
        alarmView.isHidden=false
    }
    
    @IBAction func alarmSet(_ sender: UIButton) {
        alarmView.isHidden=true
        alarmOnoff=true
    }
}
    


