//
//  Protocols.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import Foundation

protocol MenuTogleDelegate{
    
    func togleMenu()
    
}

protocol NewControllerFromMenu{
    
    func loadNewController(controllerId: String)
    
}
