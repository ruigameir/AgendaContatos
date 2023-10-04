//
//  ApagarContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 28/09/2023.
//

import Foundation

class ApagarContato: ObservableObject {
    
    @Published var userFullL: UserFull? // Uma propriedade observável para armazenar informações do usuário
    
    var id: String
    
    init(id:String) {
        self.id = id // Inicializa o ID do usuário
    }
    
    func deleteUser() {
        guard let url = URL(string: "https://dummyapi.io/data/v1/user/" + self.id) else {
            print("Invalid URL") // Verifica se a URL é válida
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE" // Define o método HTTP como DELETE
        urlReq.setValue("650c6c418b4bf3bfbaef1ca9", forHTTPHeaderField: "app-id") // Define a chave de API no cabeçalho
        
        URLSession.shared.dataTask(with: urlReq) { _, response, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)") // Lida com erros na solicitação
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200..<300).contains(httpResponse.statusCode) {
                    print("Contato excluído com sucesso.") // Verifica se o contato foi excluído com sucesso com base no código de status HTTP
                } else {
                    print("Erro ao excluir o contato. Código de status: \(httpResponse.statusCode)") // Lida com erros na exclusão
                }
            } else {
                print("Resposta inválida do servidor.") // Lida com respostas inválidas do servidor
            }
        }.resume() // Inicia a tarefa de exclusão
    }
}




