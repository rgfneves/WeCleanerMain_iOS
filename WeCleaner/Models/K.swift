//
//  K.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 10/01/22.
//

import Foundation

struct K {
    
    struct ClosedDeals {
    static let OPEN = "OPEN"
    static let EXECUTED = "EXECUTED"
    static let CANCELLED_CUSTOMER_OPEN = "CANCELLED_CUSTOMER_OPEN"
    static let CANCELLED_CUSTOMER_CLOSED = "CANCELLED_CUSTOMER_CLOSED"
    static let CANCELLED_PROFESSIONAL_OPEN = "CANCELLED_PROFESSIONAL_OPEN"
    static let CANCELLED_PROFESSIONAL_CLOSED = "CANCELLED_PROFESSIONAL_CLOSED"
    static let REFUND_CUSTOMER_OPEN = "REFUND_CUSTOMER_OPEN"
    static let REFUND_CUSTOMER_CLOSED = "REFUND_CUSTOMER_CLOSED"
        
        
        static let PAYED_BY_CUSTOMER = "PAYED_BY_CUSTOMER"
        static let REFUND_COMPLETE = "REFUND_COMPLETE"
        static let WAITING_CONFIRMATION = "WAITING_CONFIRMATION"
    }
    
    struct FirebaseCollections {
        static let USERS = "users"
        static let TICKETS = "ticket"
        static let OFFERS = "offers"
        static let CLOSED_DEALS = "closedDeal"
        static let GENERAL_INPUTS = "generalInputs"
    }
    
    
    struct defaultsKeys {
 
    
        static let id = "id"
            
        static let name = "name"
           
        static let setPassword = "setPassword"
    
        static let email = "email"

        static let typeName = "typeName"
   
        static let photo = "photo"
         
        static let cpf = "cpf"

        static let birth = "birth"
       
        static let mobile = "mobile"
    
        static let accountMoip = "accountMoip"
 
        static let token = "token"
 
        static let rewards = "rewards"
     

        static let cep = "cep"
      
        static let district = "district"
   
        static let address = "address"
   
        static let city = "city"
    
        static let compAdress = "compAdress"
    
        static let streetNumber = "streetNumber"
    
        static let cartName = "cartName"
       
        static let cartCpf = "cartCpf"
     
        static let cartStreetNumber = "cartStreetNumber"
     
        static let cartBirth = "cartBirth"
     
        static let cartCep = "cartCep"
     
        static let cartMobile = "cartMobile"
    
        static let cartNumber = "cartNumber"
    
        static let cartComp = "cartComp"
   
        static let cartCvc = "cartCvc"
   
        static let cartExp = "cartExp"
  
    
    }
    
    
    
    
}
