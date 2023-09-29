//
//  ApagarContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 28/09/2023.
//

import Foundation

class ApagarContato: ObservableObject {
    
    @Published var userFullL: UserFull?
    
    var id: String
    
    init(id:String) {
        self.id = id
        
    }
    
    func deleteUser() {
        guard let url = URL(string: "https://dummyapi.io/data/v1/user/" + self.id) else {
            print("Invalid URL")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        urlReq.setValue("650c6c418b4bf3bfbaef1ca9", forHTTPHeaderField: "app-id")
        
        URLSession.shared.dataTask(with: urlReq) { _, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200..<300).contains(httpResponse.statusCode) {
                    print("Contato excluído com sucesso.")
                } else {
                    print("Erro ao excluir o contato. Código de status: \(httpResponse.statusCode)")
                }
            } else {
                print("Resposta inválida do servidor.")
            }
        }.resume()
    }
}

