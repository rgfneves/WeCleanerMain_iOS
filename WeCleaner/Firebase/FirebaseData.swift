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
    var ticketList = [Ticket]()
    var myOfferList = [Offer]()
    var generalInputs = GeneralInputs()
    var myClosedDealsList = [ClosedDeal]()
    
    
    
    
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
    
    // MARK: - LoadMyTickets
    func loadMyTickets(completion: @escaping (Error?) -> Void) {
        
        
        db.collection(K.FirebaseCollections.TICKETS)
            .whereField("creatorId", isEqualTo: UserDefaults.standard.string(forKey: K.defaultsKeys.id) ?? "" )
            .addSnapshotListener { (querySnapshot, error) in
                
                //clear list
                var ticketList = [Ticket]()
                
                
                if let e = error {
                    print("\n\n\nThere was an issue retrieving data from Firestore. \(e)\n\n\n")
                    completion(e)
                    return
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                            var ticket = Ticket()
                            
                                                       
                       
                            ticket.id = data["id"] as? String
                            ticket.status = data["status"] as? String
                            ticket.typeId = data["typeId"] as? String
                            ticket.typeName = data["typeName"] as? String
                            ticket.paymentInfo = data["paymentInfo"] as? String
                            ticket.createdAt = data["createdAt"] as? String
                            ticket.creatorId = data["creatorId"] as? String
                            ticket.closedWithId = data["closedWithId"] as? String
                            ticket.closedDealId = data["closedDealId"] as? String
                            ticket.priceExpected = data["priceExpected"] as? String
                            ticket.pictureJson = data["pictureJson"] as? String
                            ticket.address = data["address"] as? String
                            ticket.district = data["district"] as? String
                            ticket.city = data["city"] as? String
                            ticket.jobDate = data["jobDate"] as? String
                            ticket.partnerQuestionsJson = data["partnerQuestionsJson"] as? String
                            ticket.comments = data["comments"] as? String
                            ticket.userToken = data["userToken"] as? String
                            ticket.time = data["time"] as? String
           
                            ticketList.append(ticket)
                            
                        }
                        
                        self.ticketList = ticketList
                        
                        completion(nil)
                        
                    }
                }
            }
    }
    
    
    
    
    
    // MARK: - LoadGeneralInputs
    func loadGeneralInputsUserAgree(completion: @escaping (Error?) -> Void) {
        
        
        db.collection(K.FirebaseCollections.GENERAL_INPUTS)
            .addSnapshotListener { (querySnapshot, error) in
                
       
                if let e = error {
                    print("\n\n\nThere was an issue retrieving data from Firestore. \(e)\n\n\n")
                    completion(e)
                    return
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                            var generalInputs = GeneralInputs()
         
                            generalInputs.userAgreement = data["userAgreement"] as? String
                
                            self.generalInputs = generalInputs
                            
                            completion(nil)
                        }
                        
                        
                        
                        completion(nil)
                        
                    }
                }
            }
    }
    
    
    // MARK: - LoadMyOffers
    func loadMyOffersWithId(completion: @escaping (Error?) -> Void) {
        
        
        db.collection(K.FirebaseCollections.OFFERS)
            .whereField("userId", isEqualTo: UserDefaults.standard.string(forKey: K.defaultsKeys.id) ?? "" )
            .whereField("status", isEqualTo: "VALID" )
            .addSnapshotListener { (querySnapshot, error) in
                
                //clear list
                var offerList = [Offer]()
                
                
                if let e = error {
                    print("\n\n\nThere was an issue retrieving data from Firestore. \(e)\n\n\n")
                    completion(e)
                    return
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                            var offer = Offer()
                                                                                  
                       
                            offer.id = data["id"] as? String
                            offer.priceOffer = data["priceOffer"] as? String
                            offer.status = data["status"] as? String
                            offer.ticketId = data["ticketId"] as? String
                            offer.professionalId = data["professionalId"] as? String
                            offer.professionalName = data["professionalName"] as? String
                            offer.professionalPhoto = data["professionalPhoto"] as? String
                            offer.professionalMobile = data["professionalMobile"] as? String
                            offer.professionalToken = data["professionalToken"] as? String
                            offer.comment = data["comment"] as? String
                            offer.createdAt = data["createdAt"] as? String
                            offer.userId = data["userId"] as? String
                            offer.accountMoip = data["accountMoip"] as? String
                            offer.jobDate = data["jobDate"] as? String
                           
                        
           
                            offerList.append(offer)
                            
                        }
                        
                        self.myOfferList = offerList
                        
                        completion(nil)
                        
                    }
                }
            }
    }
    
    // MARK: - LoadMyClosedDeals
    func loadMyClosedDeals(completion: @escaping (Error?) -> Void) {
        
        
        db.collection(K.FirebaseCollections.CLOSED_DEALS)
            .whereField("userId", isEqualTo: UserDefaults.standard.string(forKey: K.defaultsKeys.id) ?? "" )
            .addSnapshotListener { (querySnapshot, error) in
                
                //clear list
                var closedDealsList = [ClosedDeal]()
                
                
                if let e = error {
                    print("\n\n\nThere was an issue retrieving data from Firestore. \(e)\n\n\n")
                    completion(e)
                    return
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                           
                            var closedDeals = ClosedDeal()
                                                                                  
                       
                            closedDeals.id = data["id"] as? String
                            closedDeals.moipOrderId = data["moipOrderId"] as? String
                            closedDeals.ticketId = data["ticketId"] as? String
                            closedDeals.paymentInfo = data["paymentInfo"] as? String
                            closedDeals.userCellphone = data["userCellphone"] as? String
                            closedDeals.userName = data["userName"] as? String
                            closedDeals.professionalCellphone = data["professionalCellphone"] as? String
                            closedDeals.professionalName = data["professionalName"] as? String
                            closedDeals.professionalToken = data["professionalToken"] as? String
                            closedDeals.userToken = data["userToken"] as? String
                            closedDeals.completeAddress = data["completeAddress"] as? String
                            closedDeals.price = data["price"] as? String
                            closedDeals.pricePayed = data["pricePayed"] as? String
                            closedDeals.status = data["status"] as? String
                            closedDeals.jobDate = data["jobDate"] as? String
                            closedDeals.createdAt = data["createdAt"] as? String
                            closedDeals.userId = data["userId"] as? String
                            closedDeals.professionalId = data["professionalId"] as? String
                            closedDeals.jsonMoipOrder = data["jsonMoipOrder"] as? String
                            closedDeals.jsonMoipPayment = data["jsonMoipPayment"] as? String
                            closedDeals.usingReward = data["usingReward"] as? String
                            closedDeals.discountPrice = data["discountPrice"] as? String
                            closedDeals.time = data["time"] as? String
                            closedDeals.typeName = data["typeName"] as? String
              
                        
           
                            closedDealsList.append(closedDeals)
                            
                        }
                        
                        self.myClosedDealsList = closedDealsList
                        
                        completion(nil)
                        
                    }
                }
            }
    }
    
    
   
    
    // MARK: - LoadBooks
    
    
    
}

