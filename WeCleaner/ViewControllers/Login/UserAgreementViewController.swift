//
//  UserAgreementViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 11/01/22.
//

import UIKit
import Firebase

class UserAgreementViewController: UIViewController {

    @IBOutlet weak var userAgreeTextField: UITextView!
    
    var timer2 = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserAgree()


        
    }
    
    @objc func loadUserAgree(){
        
        FirebaseData.sharedData.loadGeneralInputsUserAgree() {
            error in
            
            if error != nil {
                
                print("Error geting Agreement from firebase")
                
                self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadUserAgree), userInfo: nil, repeats: false)
                
                
            }else {
                self.timer2.invalidate()
                //convert to a readble html text
                
                self.userAgreeTextField.attributedText = FirebaseData.sharedData.generalInputs.userAgreement!.htmlAttributedString(size: CGFloat(15), color: UIColor.init(red: 0.5, green: 0.5, blue: 0.9999912977, alpha: 1))
                
              //  self.userAgreeTextField.text = FirebaseData.sharedData.generalInputs.userAgreement
                print(FirebaseData.sharedData.generalInputs.userAgreement ?? "404 - not found")
 
                
            }
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer2.invalidate()

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
