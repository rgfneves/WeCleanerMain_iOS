//
//  ForgotPassViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//

import UIKit
import Firebase


class ForgotPassViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
       
        if let email = emailTextField.text{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil{
                    print("Error: could not send the email")
                    self.showToast(message: "Confirme seu e-mail", font: .systemFont(ofSize: 12.0))
                }else{
                    print("Success: email sent")
                    self.showToast(message: "E-mail enviado!", font: .systemFont(ofSize: 12.0))
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
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
