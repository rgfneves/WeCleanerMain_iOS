//
//  File.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 11/01/22.
//

import Foundation
import SWXMLHash
import WebKit

struct ApiViaCep {
    
    static func postRequest(cep: String,
                     completion: @escaping (Adress?, Error?) -> Void){
        //URL válida
        
        //Coloque a URL da sua API aqui
        let url = "https://viacep.com.br/ws/\(cep)/xml/"
    
        let URL = URL(string: url)
        
        //Cria a representacão da requisição
        let request = NSMutableURLRequest(url: URL!)
        
        //Atribui à requisiçāo o método POST
        request.httpMethod = "GET"

        
        //Cria a tarefa de requisição
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            if let data = data {
            
                                
                let xml = XMLHash.parse(data)
                
                var adress = Adress()
                

                
                adress.cep = xml["xmlcep"]["cep"].element?.text
                adress.bairro = xml["xmlcep"]["bairro"].element?.text
                adress.localidade = xml["xmlcep"]["localidade"].element?.text
                adress.logradouro = xml["xmlcep"]["logradouro"].element?.text
                adress.uf = xml["xmlcep"]["uf"].element?.text

                
                completion(adress, nil)
            }
            else {
                //Não houve resposta
                completion(nil, error)
            }
            
        }

        //Aciona a tarefa
        task.resume()
    }
    
    
}
