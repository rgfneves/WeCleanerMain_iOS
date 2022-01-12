//
//  ApiMoip.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 11/01/22.
//

import Foundation
import SWXMLHash


struct ApiMoip {
    
    static func postRequest(params: String, urlComp: String,
                     completion: @escaping (Bool, NSString?, String?) -> Void){
        //URL válida
        
        //Coloque a URL da sua API aqui
        let url = "https://sandbox.moip.com.br/v2/" + urlComp
    
        let URL = URL(string: url)
        
        //Cria a representacão da requisição
        let request = NSMutableURLRequest(url: URL!)
        
        let paramsToData = params.data(using: String.Encoding.utf8)
        let paramsCount = params.count
          
        //Atribui à requisiçāo o método POST
        request.httpMethod = "POST"
        
        //Codifica o corpo da mensagem em "data" usando utf8
        request.httpBody = paramsToData
        request.addValue(MySecrets.Oauth, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(paramsCount)", forHTTPHeaderField: "Content-Length")
        
        
        //Cria a tarefa de requisição
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            if let data = data {
      
                                
               var myJsonNstring = NSString(data: data, encoding:String.Encoding.utf8.rawValue)!
                
                print(myJsonNstring)
                
                let decoder = JSONDecoder()
                
   
                do {
                    let apiResponse = try decoder.decode(ApiResponse.self, from: data)
               
                    let id = apiResponse.id
                   print("Esse é o codigo " + id)
                    
                    completion(true, myJsonNstring, id)
                    
                } catch {
                    
                    completion(false, nil, nil)
                    print(error)
                }

   
                                            
            }
            else {
                //Não houve resposta
                completion(false, nil, nil)
            }
            
        }
        
        
        //Aciona a tarefa
        task.resume()
    }
    
    
}
