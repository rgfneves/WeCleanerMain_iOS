//
//  RegisterProfessionalViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 11/01/22.
//

import Firebase
import FirebaseDatabase
import UIKit

class RegisterProfessionalViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var cpf: UITextField!
    
    @IBOutlet weak var birth: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var cellphone: UITextField!
    
    @IBOutlet weak var cep: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var neiborhood: UITextField!
    
    @IBOutlet weak var streetNumber: UITextField!
    
    @IBOutlet weak var street: UITextField!
    
    @IBOutlet weak var addressComp: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var acceptedUserAgreements: UISwitch!
    
    @IBOutlet weak var acceptedMoipAgreements: UISwitch!
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var registerView: UIStackView!
    
    

    let defaults = UserDefaults.standard
    
    var user = User()
    
    
    //TODO: quedstáo da foto
    var photoToSaveUrl = ""
    let myUuid = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //confirmar se esta tudo preenchido e senhas iguais
        // criar usuario no Firebase
        // Salvar USER  na collectionm users
        // salvar user localmente
        // abrir activity
        acceptedUserAgreements.isOn = false
        
    }
    


    
    @IBAction func mobileTextDidChange(_ sender: Any) {
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
       
        if cep.text?.count == 10 {
            callCepApi()
        }
    }

    
    @IBAction func registerNewUser(_ sender: UIButton) {
        checkEmail()
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
                    self.street.text = adress?.logradouro
                    self.neiborhood.text = adress?.bairro
                }
                
            }
            
        }
        
        
        
        	
    }
    
    func checkEmail(){
        
        Auth.auth().fetchSignInMethods(forEmail: email.text ?? ""){
            (string, error) in
            
            if(string == nil){
                self.checkAll()
            }else{
                self.showToast(message: "Contate o administrador", font: .systemFont(ofSize: 12.0))
            }
          //  print(error)
            
            
        }
    //    checkAll()
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
        if streetNumber.text == nil{
            self.showToast(message: "Digite o número da sua casa", font: .systemFont(ofSize: 12.0))
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
   
        
        
        
    }
    
    func createMoipUser(){
        
        let firstName = name.text?.split(separator: " ")[0] ?? " "
        
        let lastName = name.text!.replacingOccurrences(of: firstName, with: "")
        
        var myBirthFinal = ""
        
        let birthFinalArray = birth.text?.split(separator: "/")
        
        if birthFinalArray?.count != 3 {
            self.showToast(message: "Digite nascimento completo", font: .systemFont(ofSize: 12.0))
            return
            
        }else{
            
            myBirthFinal = birthFinalArray![2] + "-" + birthFinalArray![1] + "-" + birthFinalArray![0]
            
        }
        
        var ddd = ""
        var mobileNumber = ""
        
        if cellphone.text?.count != 15 {
            self.showToast(message: "Digite o celular", font: .systemFont(ofSize: 12.0))
            return
        }else{
            ddd = String((cellphone.text?.dropFirst(1) ?? ""))
            ddd = String(ddd.dropLast(12))
            //print(Meu DDD é \(ddd)")
            mobileNumber = String((cellphone.text?.dropFirst(5) ?? ""))
            mobileNumber = String(mobileNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil))
           // print("Meu mobile é \(mobileNumber)")
        }
        
        let newCep = String(cep.text!.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil))
    
        
        let myJson = """
{
                "email":{
                "address":"\(email.text!)"
            },
                "person":{
                "name":"\(firstName)",
                "lastName":"\(lastName)",
                "taxDocument":{
                "type":"CPF",
                "number":"\(String(cpf.text!))"
            },
                "birthDate":"\(myBirthFinal)",
                "phone":{
                "countryCode":"55",
                "areaCode":"\(ddd)",
                "number":"\(mobileNumber)"
            },
                "address":{
                "street":"\(String(street.text!))",
                "streetNumber":"\(String(streetNumber.text!))",
                "district":"\(String(neiborhood.text!))",
                "zipCode":"\(newCep)",
                "city":"\(String(city.text!))",
                "state":"\(String(state.text!))",
                "country":"BRA"
            }
            },
                "type":"MERCHANT"
            }
"""
        print(myJson)
     
        
        ApiMoip.postRequest(params: myJson, urlComp: "accounts#"){
            (response, myJson, id) in
            
            if response{
               
                let temp: String = myJson! as String
                self.user.jsonMoip = temp
                
                self.user.accountMoip = id
                
                self.createFirebaseUser()
                //save user to firebase
                //TODO:
            }else{
                print("Error. Try Again")
                self.showToast(message: "Erro: tente novamente", font: .systemFont(ofSize: 12.0))
                
            }
            
        }
    
        
    }
    
    
    
    func createFirebaseUser(){
        
      
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            
            if error != nil{
                print(error?.localizedDescription ?? "")
                self.showToast(message: "Contate o administrador", font: .systemFont(ofSize: 12.0))
                return
            }else{
                
                self.saveUserToDataBase()
                
            }
            
            
        }
        
        
    }
    
    func saveUserToDataBase(){
        
       
        
        
        let userInfoDictionary = [
            "id" : myUuid,
            "name" : name.text!,
            "email" : email.text!,
            "cellphone" : cellphone.text!,
            "cep" : cep.text!,
            "city" : city.text!,
            "reward" : "0",
            "typeName" : "PROFESSIONAL",
            "acceptedUserAgreement" : "true",
            "jsonMoip" : user.jsonMoip,
            "district" : neiborhood.text!,
            "number" : streetNumber.text!,
            "photo" : photoToSaveUrl,
            "birth" : birth.text!,
            "addressComp" : addressComp.text!,
            "accountMoip" : user.accountMoip,
            "setPassword" : "false"
        ]
        
        
        
        
        let db = Firestore.firestore() // 1
        
        do { // 2!
            try db.collection(K.FirebaseCollections.USERS).document(myUuid).setData(userInfoDictionary)
            
            var user = User()
            user.id = userInfoDictionary["id"]!
            user.name = name.text!
            user.email = email.text!
            user.cellphone = cellphone.text!
            user.cep = cep.text!
            user.cpf = cpf.text!
            user.city = city.text!
            user.reward = "0"
            user.acceptedUserAgreement = "true"
            user.district = neiborhood.text!
            user.number = streetNumber.text!
            user.photo = photoToSaveUrl
            user.birth = birth.text!
            user.addressComp = addressComp.text!
            user.setPassword = "false"
            
            
            saveLocally(user: user)
            
            
        } catch {
             print(error)
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
        
        print("saved")
        
        //TODO: open main activity
        
    }
    
    @IBAction func takePic(_ sender: UIButton) {
        selectImageFrom()
    }
    
    
    func selectImageFrom(){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self

            imagePicker.sourceType = .camera
    
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImageFirebase(img1 :UIImage!){
       
        let storage = Storage.storage()
        
        let storageRef = storage.reference()
        
        let data = img1.jpegData(compressionQuality: 0.8)! as Data

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("pictures/\(myUuid)")

        // Upload the file to the path "images/rivers.jpg"
        _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
            // Uh-oh, an error occurred!
            return
          }
        
          riversRef.downloadURL { (url, error) in
            if let downloadURL = url {
              print(downloadURL)
                self.photoToSaveUrl = downloadURL.absoluteString
                self.registerView.isHidden = false
              return
            }
          }
        }
        
    }
    
    
}

extension RegisterProfessionalViewController: UIImagePickerControllerDelegate{

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
       imagePicker.dismiss(animated: true, completion: nil)
       guard let selectedImage = info[.originalImage] as? UIImage else {
           print("Image not found!")
           return
       }
       saveImageFirebase(img1: selectedImage)
   }
}
