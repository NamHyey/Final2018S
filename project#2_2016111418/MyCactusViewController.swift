//
//  MyCactusViewController.swift
//  project#2_2016111418
//
//  Created by SWUCOMPUTER on 2018. 6. 13..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit


    
    class MyCactusViewController: UIViewController, UITextFieldDelegate {
        
        @IBOutlet var myView2: UIView!
        @IBOutlet var cactus: UIImageView!
        @IBOutlet var myView: UIView!
        
        @IBOutlet var flower2: UIImageView!
        @IBOutlet var flower1: UIImageView!
        var myinfo:Int?
        var cactuslevel:Int?
        
        override func viewDidLoad() {
                        super.viewDidLoad()
            myView2.isHidden=true
            myView.isHidden=false

            flower1.isHidden=true
            flower2.isHidden=true

            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "main_background.png")!)
            self.myView.backgroundColor = UIColor(patternImage: UIImage(named: "main_view.png")!)
            self.myView2.backgroundColor = UIColor(patternImage: UIImage(named: "main_view2.png")!)
            
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            if let name=appDelegate.userName{
                self.title=name
            }
            
            if let content=myinfo{
                cactuslevel=content
       
                
                if (cactuslevel!>3){
                    if(cactuslevel!>4){
                        flower1.isHidden=false
                        flower2.isHidden=false
                    }else{
                        flower1.isHidden=true
                        flower2.isHidden=true
                        cactus.isHighlighted=true
                        
                    }
                }else{
                    cactus.isHighlighted=true
                }
                
            }
            
            
            
        }
        
        
        
        @IBAction func showView(_ sender: UIButton) {
            myView2.isHidden=false
            myView.isHidden=true
        }
        
        
        @IBAction func backShow(_ sender: UIButton) {
            myView2.isHidden=true
            myView.isHidden=false
        }
        
        
        @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
            let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in let urlString: String = "http://condi.swu.ac.kr/student/W03iphone/logout.php"
                guard let requestURL = URL(string: urlString) else { return }
                var request = URLRequest(url: requestURL)
                request.httpMethod = "POST"
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (responseData, response, responseError) in
                    guard responseError == nil else { return } }
                task.resume()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
                self.present(loginView, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        

        
        
      

}
