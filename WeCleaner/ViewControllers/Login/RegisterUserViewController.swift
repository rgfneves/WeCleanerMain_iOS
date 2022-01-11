//
//  RegisterUserViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var cellphone: UITextField!
    
    @IBOutlet weak var cep: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var acceptedUserAgreements: UISwitch!
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //confirmar se esta tudo preenchido e senhas iguais
        // criar usuario no Firebase
        // Salvar USER  na collectionm users
        // salvar user localmente
        // abrir activity
        acceptedUserAgreements.isOn = false
        
    }
    
    
    @IBAction func cellphoneTextDidChange(_ sender: UITextField) {
        
        cellphone.text = Mask.format(with: "(XX) XXXXX-XXXX", phone: cellphone.text ?? "")
        
    }
    @IBAction func cepTextDidChange(_ sender: UITextField) {
        cep.text = Mask.format(with: "XX.XXX-XXX", phone: cep.text ?? "")
        
        if cep.text?.count == 10 {
            callCepApi()
        }
    }
    
    @IBAction func registerNewUser(_ sender: UIButton) {
        checkAll()
    }
    
    func callCepApi(){
        var cepLocal = cep.text!.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        cepLocal = cepLocal.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        ApiViaCep.postRequest(cep: cepLocal){
            (adress, err)  in
            
            if let error = err {
                
                print("ocorreu um erro: \(error.localizedDescription)")
                self.showToast(message: "\(error.localizedDescription)", font: .systemFont(ofSize: 12.0))
                
            }else{
                
                DispatchQueue.main.async {
                    
                    self.state.text = adress?.uf
                    self.city.text = adress?.localidade
                    //                self.street.text = adress?.logradouro
                    //                self.neiborhood.text = adress?.bairro
                }
                
            }
            
        }
        
        
        
        
    }
    
    
    func checkAll(){
        
        if acceptedUserAgreements.isOn == false{
            self.showToast(message: "Aceite os termos", font: .systemFont(ofSize: 12.0))
            return
        }
        
        if name.text == nil {
            self.showToast(message: "Digite seu nome", font: .systemFont(ofSize: 12.0))
            return
        }
        if email.text == nil{
            self.showToast(message: "Digite seu e-mail", font: .systemFont(ofSize: 12.0))
            return
        }
        if cellphone.text == nil{
            self.showToast(message: "Digite seu celular", font: .systemFont(ofSize: 12.0))
            return
        }
        if cep.text == nil{
            self.showToast(message: "Digite seu cep", font: .systemFont(ofSize: 12.0))
            return
        }
        if city.text == nil{
            self.showToast(message: "Digite sua cidade", font: .systemFont(ofSize: 12.0))
            return
        }
        if state.text == nil{
            self.showToast(message: "Digite seu estado", font: .systemFont(ofSize: 12.0))
            return
        }
        if password.text == nil{
            self.showToast(message: "Digite sua senha", font: .systemFont(ofSize: 12.0))
            return
        }
        if password.text != confirmPassword.text {
            self.showToast(message: "Confirme sua senha", font: .systemFont(ofSize: 12.0))
            return
            
        }
        
        createFirebaseUser()
        
        
        
    }
    func createFirebaseUser(){
        
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            
            if error != nil{
                print(error?.localizedDescription ?? "")
                self.showToast(message: "Tente novamente", font: .systemFont(ofSize: 12.0))
                return
            }else{
                
                self.saveUserToDataBase()
                
            }
            
            
        }
        
        
    }
    
    func saveUserToDataBase(){
        
        
        
        let userInfoDictionary = [
            "id" : UUID().uuidString,
            "name" : name.text!,
            "email" : email.text!,
            "cellphone" : cellphone.text!,
            "cep" : cep.text!,
            "city" : city.text!,
            "reward" : "0",
            "typeName" : "USER",
        ]
        
        
        
        let db = Firestore.firestore() // 1
        
        do { // 2
            try db.collection(K.FirebaseCollections.USERS).document(userInfoDictionary["id"]!).setData(userInfoDictionary)
            
            var user = User()
            user.id = userInfoDictionary["id"]!
            user.name = name.text!
            user.email = email.text!
            user.cellphone = cellphone.text!
            user.cep = cep.text!
            user.city = city.text!
            user.reward = "0"
            saveLocally(user: user)
        } catch {
            // handle the error here
        }
        
        
    }
    
    func saveLocally(user: User){
        
        defaults.set(user.email ?? "", forKey: K.defaultsKeys.email)
        defaults.set(user.name ?? "", forKey: K.defaultsKeys.name)
        defaults.set(user.cpf ?? "", forKey: K.defaultsKeys.cpf)
        defaults.set(user.cep ?? "", forKey: K.defaultsKeys.cep)
        defaults.set(user.accountMoip ?? "", forKey: K.defaultsKeys.accountMoip)
        defaults.set(user.address ?? "", forKey: K.defaultsKeys.address)
        defaults.set(user.id ?? "", forKey: K.defaultsKeys.id)
        defaults.set(user.district ?? "", forKey: K.defaultsKeys.district)
        defaults.set(user.number ?? "", forKey: K.defaultsKeys.streetNumber)
        defaults.set(user.birth ?? "", forKey: K.defaultsKeys.birth)
        defaults.set(user.typeName ?? "", forKey: K.defaultsKeys.typeName)
        defaults.set(user.photo ?? "", forKey: K.defaultsKeys.photo)
        defaults.set(user.city ?? "", forKey: K.defaultsKeys.city)
        defaults.set(user.cellphone ?? "", forKey: K.defaultsKeys.mobile)
        defaults.set(user.setPassword ?? "", forKey: K.defaultsKeys.setPassword)
        
        //TODO: open main activity
        
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
