//
//  LoginViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//
import Firebase
import FirebaseStorage
import SDWebImage
import UIKit

class LoginViewController: UIViewController, OpenClientController, OpenProfessionalController {
    
    func openClientController() {
        actualOpenClientController()
        
    }
    
    func openProfessionalController() {
        actualOpenProfessionalController()
        
    }
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let defaults = UserDefaults.standard
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        checkCurrentUser()
        
        
    }
    
    func checkCurrentUser() {
        
        if Auth.auth().currentUser != nil {
            
            if let email = Auth.auth().currentUser?.email{
                
                defaults.set(email, forKey: K.defaultsKeys.email)
                loadUserWithEmail()
                
            }
            
            
        }
        
    }
    
    @objc func loadUserWithEmail(){
        
        FirebaseData.sharedData.loadUserWithEmail(email: defaults.string(forKey: K.defaultsKeys.email) ?? "") {  error in
            
            if error != nil || FirebaseData.sharedData.userList.count < 1{
                
                print("Error geting User from firebase")
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadUserWithEmail), userInfo: nil, repeats: false)
                
                
            }else {
                self.timer.invalidate()
                
                if FirebaseData.sharedData.userList.count > 0{
                    self.saveUserAndGo()
                    
                    
                }
                
            }
        }
        
        
    }
    
    
    func saveUserAndGo(){
        
        
        defaults.set(FirebaseData.sharedData.userList[0].email, forKey: K.defaultsKeys.email)
        defaults.set(FirebaseData.sharedData.userList[0].name, forKey: K.defaultsKeys.name)
        defaults.set(FirebaseData.sharedData.userList[0].cpf, forKey: K.defaultsKeys.cpf)
        defaults.set(FirebaseData.sharedData.userList[0].cep, forKey: K.defaultsKeys.cep)
        defaults.set(FirebaseData.sharedData.userList[0].accountMoip, forKey: K.defaultsKeys.accountMoip)
        defaults.set(FirebaseData.sharedData.userList[0].address, forKey: K.defaultsKeys.address)
        defaults.set(FirebaseData.sharedData.userList[0].id, forKey: K.defaultsKeys.id)
        defaults.set(FirebaseData.sharedData.userList[0].district, forKey: K.defaultsKeys.district)
        defaults.set(FirebaseData.sharedData.userList[0].number, forKey: K.defaultsKeys.streetNumber)
        defaults.set(FirebaseData.sharedData.userList[0].birth, forKey: K.defaultsKeys.birth)
        defaults.set(FirebaseData.sharedData.userList[0].typeName, forKey: K.defaultsKeys.typeName)
        defaults.set(FirebaseData.sharedData.userList[0].photo, forKey: K.defaultsKeys.photo)
        defaults.set(FirebaseData.sharedData.userList[0].city, forKey: K.defaultsKeys.city)
        defaults.set(FirebaseData.sharedData.userList[0].cellphone, forKey: K.defaultsKeys.mobile)
        defaults.set(FirebaseData.sharedData.userList[0].setPassword, forKey: K.defaultsKeys.setPassword)
        
        
        if FirebaseData.sharedData.userList[0].typeName ?? "" == "USER"{
            openClientController()
        }else{
            openProfessionalController()
        }
        
        
    }
    func actualOpenProfessionalController(){
               

        
       
        
    }
    func actualOpenClientController(){
        
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "ContainerClientViewController") as! ContainerClientViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()

       
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let strongSelf = self {
                    
                    if error != nil {
                        //TODO notify user
                        print("Firebase Login: Something went wrong")
                        return
                    }else{
                        print("Login: "+(Auth.auth().currentUser?.email ?? "failed") )
                    }
                    
                    strongSelf.defaults.set(email, forKey: K.defaultsKeys.email)
                    strongSelf.loadUserWithEmail()
                    return
                    
                }
                
                
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
