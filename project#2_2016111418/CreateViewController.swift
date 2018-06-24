//
//  CreateViewController.swift
//  project#2_2016111418
//
//  Created by SWUCOMPUTER on 2018. 6. 13..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textName: UITextField!
    @IBOutlet var textEmail: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "createview.png")!)
        
        
    }
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        
        if textField == self.textID {
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        }
        else if textField == self.textPassword {
            textField.resignFirstResponder()
            self.textName.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    @IBAction func buttonSave()
    {
        if textID.text == "" {
            labelStatus.text = "사용자 이름를 입력하세요"; return; }
        if textPassword.text == "" {
            labelStatus.text = "ID를 입력하세요"; return; }
        if textName.text == "" {
            labelStatus.text = "Password을 입력하세요"; return; }
        if textEmail.text == "" {
            labelStatus.text = "E-mail를 입력하세요"; return;
            
        }
        let urlString: String = "http://condi.swu.ac.kr/student/W03iphone/insertUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + textID.text! + "&password=" + textPassword.text! + "&name=" + textName.text! + "&email="+textEmail.text!
        request.httpBody = restString.data(using: .utf8)
        self.executeRequest(request: request)
        
    }
    @IBAction func buttonBack()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
                
            }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
                
            }
            if let utf8Data = String(data: receivedData, encoding: .utf8){
                DispatchQueue.main.async { // for Main Thread Checker
                    self.labelStatus.text = utf8Data
                    print(utf8Data)
                }
            }
        }
        task.resume() }
    
}


