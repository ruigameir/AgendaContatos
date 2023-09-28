//
//  usr.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 26/09/2023.
//

import Foundation

struct User:Codable, Identifiable{
    
    var id: String
    var firstName: String
    var lastName: String
    var title: String
    var picture:String
    var email:String?
    
}

struct UsersData: Codable{
    
    var data:[User]
}

class LoadData:ObservableObject{
    
    let apiKey:String
    @Published var users:[User] = []
    
    var currentPage: Int = 0 // Começa da página 0
    let baseURL: String = "https://dummyapi.io/data/v1/user?page="
    
    
    init() {
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
        self.getData()
    }
    
    
    func getData() {
        let urlString = "\(baseURL)\(currentPage)&limit=50"
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }
        
        
        var urlReq = URLRequest(url: url)
        
        urlReq.httpMethod = "GET"
        
        urlReq.setValue(apiKey, forHTTPHeaderField: "app-id")
        
        URLSession.shared.dataTask(with: urlReq) { data, _, error in
            if let error = error {
                print("Erro na solicitação: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Dados vazios ou ausentes na resposta.")
                return
            }
            
            if let usersData = try? JSONDecoder().decode(UsersData.self, from: data) {
                DispatchQueue.main.async {
                    self.users += usersData.data // Adiciona os novos usuários à lista existente
                    self.currentPage += 1 // Incrementa o número da página
                    self.getData() // Chama novamente a função para buscar a próxima página
                }
            } else {
                if self.currentPage == 0 {
                    print("Erro ao decodificar JSON: Os dados não puderam ser decodificados.")

                }
            }
            
            
        }.resume()
    }
    
}
