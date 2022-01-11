//
//  File.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//


import Foundation
import Firebase

protocol UpdateUser {
    
    func UpdateUser()
    
}



class FirebaseData {
    
    
    
    
    let db = Firestore.firestore()
    
    static let sharedData = FirebaseData()
    
    var userList = [User]()
    
    
    
    
    
    
    // MARK: - LoadUsers
    func loadUserWithEmail(email: String, completion: @escaping (Error?) -> Void) {
        
        
        db.collection(K.FirebaseCollections.USERS)
            .whereField("email", isEqualTo: email)
            .addSnapshotListener { (querySnapshot, error) in
                
                //clear list
                var userList = [User]()
                
                
                if let e = error {
                    print("\n\n\nThere was an issue retrieving data from Firestore. \(e)\n\n\n")
                    completion(e)
                    return
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                            var user = User()
                            
                                                       
                       
                            user.id = data["id"] as? String
                            user.name = data["name"] as? String
                            user.email = data["email"] as? String
                            user.cpf = data["cpf"] as? String
                            user.cellphone = data["cellphone"] as? String
                            user.bonusCount = data["bonusCount"] as? String
                            user.acceptedUserAgreement = data["acceptedUserAgreement"] as? String
                            user.cep = data["cep"] as? String
                            user.address = data["address"] as? String
                            user.number = data["number"] as? String
                            user.district = data["district"] as? String
                            user.city = data["city"] as? String
                            user.typeName = data["typeName"] as? String
                            user.region = data["region"] as? String
                            user.photo = data["photo"] as? String
                            user.description = data["description"] as? String
                            user.jsonMoip = data["jsonMoip"] as? String
                            user.accountMoip = data["accountMoip"] as? String
                            user.token = data["token"] as? String
                            user.birth = data["birth"] as? String
                            user.addressComp = data["addressComp"] as? String
                            user.reward = data["reward"] as? String
                            user.setPassword = data["setPassword"] as? String
                            
                            
                            
                            
                            
                            userList.append(user)
                            
                        }
                        
                        self.userList = userList
                        
                        completion(nil)
                        
                    }
                }
            }
    }
    
    
    // MARK: - LoadBooks
    
    
    
}

