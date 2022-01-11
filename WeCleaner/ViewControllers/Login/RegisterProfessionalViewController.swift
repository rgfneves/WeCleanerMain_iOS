//
//  RegisterProfessionalViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 11/01/22.
//

import Firebase
import FirebaseDatabase
import UIKit

class RegisterProfessionalViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var cpf: UITextField!
    
    @IBOutlet weak var birth: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var cellphone: UITextField!
    
    @IBOutlet weak var cep: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var neiborhood: UITextField!
    
        
    @IBOutlet weak var street: UITextField!
    
    @IBOutlet weak var complement: UITextField!
        
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var acceptedUserAgreements: UISwitch!
    @IBOutlet weak var acceptedMoipAgreements: UISwitch!
    
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
    
    @IBAction func cpfTextDidChange(_ sender: UITextField) {
        cpf.text = Mask.format(with: "XXX.XXX.XXX-XX", phone: cpf.text ?? "")
    }
    
    @IBAction func birthTextDidChange(_ sender: UITextField) {
        birth.text = Mask.format(with: "XX/XX/XXXX", phone: birth.text ?? "")
    }
    
    @IBAction func cepTextDidChange(_ sender: UITextField) {
        cep.text = Mask.format(with: "XX.XXX-XXX", phone: cep.text ?? "")
    }
    
    
    @IBAction func registerNewUser(_ sender: UIButton) {
        checkAll()
    }
    
    
    func checkAll(){
        
        if acceptedUserAgreements.isOn == false{
            self.showToast(message: "Aceite os termos", font: .systemFont(ofSize: 12.0))
            return
        }
        
        if acceptedMoipAgreements.isOn == false{
            self.showToast(message: "Aceite os termos", font: .systemFont(ofSize: 12.0))
            return
        }
        
        if name.text == nil {
            self.showToast(message: "Digite seu nome", font: .systemFont(ofSize: 12.0))
            return
        }
        if cpf.text == nil {
            self.showToast(message: "Digite seu CPF", font: .systemFont(ofSize: 12.0))
            return
        }
        if birth.text == nil {
            self.showToast(message: "Digite seu nascimento", font: .systemFont(ofSize: 12.0))
            return
        }
        if street.text == nil {
            self.showToast(message: "Digite sua Rua", font: .systemFont(ofSize: 12.0))
            return
        }
        if neiborhood.text == nil {
            self.showToast(message: "Digite seu bairro", font: .systemFont(ofSize: 12.0))
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
        
        createMoipUser()
    //    createFirebaseUser()
        
        
        
    }
    
    func createMoipUser(){
        
        
        
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
