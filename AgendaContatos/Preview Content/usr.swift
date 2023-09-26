//
//  usr.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 26/09/2023.
//

import Foundation

struct user:Codable,Identifiable{
    
    var id: Int
    var firstName: String
    var lastname: String
    var title: String
}

struct usersData: Codable{
    
    var data:[user]
}

class loadData:ObservableObject{
       
    let url:URL
    let apiKey:String
    var users:[user] = []
    
    init(url: String) {
        self.url = URL(string: "https://dummyapi.io/data/v1/user")!
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
    }
    
    func getData() {
      
      
        var urlReq = URLRequest(url: url)

        urlReq.httpMethod = "GET"

        urlReq.setValue(apiKey, forHTTPHeaderField: "app-id")
        //urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
    
        URLSession.shared.dataTask(with: urlReq) { data, _, error in
                    if let error = error {
                        print("Erro na solicitação: \(error.localizedDescription)")
                        return
                    }

                    guard let data = data else {
                        print("Dados vazios ou ausentes na resposta.")
                        return
                    }

                    if let usersData = try? JSONDecoder().decode(usersData.self, from: data) {
                        DispatchQueue.main.async {
                            self.users = usersData.data
                        }
                    } else {
                        print("Erro ao decodificar JSON: Os dados não puderam ser decodificados.")
                    }
                
                }.resume()
}
}
