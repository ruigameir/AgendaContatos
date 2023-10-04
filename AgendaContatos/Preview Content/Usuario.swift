//
//  usr.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 26/09/2023.
//

import Foundation

// Definição da estrutura User que representa um usuário
struct User:Codable, Identifiable{
    
    var id: String
    var firstName: String
    var lastName: String
    var title: String
    var picture:String
    var email:String?
    
}

// Definição da estrutura UsersData para representar um container de dados de usuário
struct UsersData: Codable{
    
    var data:[User]
}

// Classe LoadData para carregar e gerir dados de usuários
class LoadData:ObservableObject{
    
    let apiKey:String
    // Uma lista observável que armazenará os dados dos usuários
    @Published var users:[User] = []
    
    var currentPage: Int = 0 // Começa da página 0
    let baseURL: String = "https://dummyapi.io/data/v1/user?page="
    
    // Inicialização da classe LoadData com uma chave de API padrão e a busca inicial de dados
    init() {
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
        self.getData() // Quando uma instância LoadData é criada, inicia a busca de dados
    }
    
    // Função para buscar dados de usuários da API
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
            
            // Tenta decodificar os dados JSON em uma estrutura UsersData
            if let usersData = try? JSONDecoder().decode(UsersData.self, from: data) {
                DispatchQueue.main.async {
                    self.users += usersData.data // Adiciona os novos usuários à lista existente
                    self.currentPage += 1 // Incrementa o número da página
                    self.getData() // Chama novamente a função para buscar a próxima página
                }
            } else {
                // Se a decodificação falhar, imprime uma mensagem de erro
                if self.currentPage == 0 {
                    print("Erro ao decodificar JSON: Os dados não puderam ser decodificados.")
                    
                }
            }
        }.resume() // Inicia a tarefa de busca de dados
    }
    
    // Função para atualizar os dados da API
    func updateData() {
        currentPage = 0 // Reinicia a página para buscar a partir da primeira página
        users.removeAll() // Remove os dados existentes
        getData() // Chama a função para buscar os novos dados
    }
}
