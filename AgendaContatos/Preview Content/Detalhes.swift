//
//  ContatoIndividual.swift
//  AgendaDeContatos
//
//  Created by Bruno Silva on 28/09/2023.
//

import Foundation
import SwiftUI

// A estrutura Detalhes é responsável por exibir informações detalhadas de um usuário.
struct Detalhes: View {
    
    var user: User
    @ObservedObject var userCompleto: GetAllInfo
    
    // Inicializador que recebe um usuário e uma instância de GetAllInfo.
    init(user: User) {
        self.user = user
        self.userCompleto = GetAllInfo(id: user.id)
        userCompleto.getUserFull() // Obtém informações detalhadas do usuário.
    }
    
    var body: some View {
        VStack {
            Form{
                Section("Informações do Usuário"){
                    // Exibe informações detalhadas do usuário com base nos dados obtidos.
                    Text("Nome: " + "\(userCompleto.userFullL?.title ?? "Not found")" + " " + "\(userCompleto.userFullL?.firstName ?? "Not found") \(userCompleto.userFullL?.lastName ?? "Not found")")
                    Text("Género: " + "\(userCompleto.userFullL?.gender ?? "Not found")")
                    Text("E-mail: " + "\(userCompleto.userFullL?.email ?? "Not found")")
                    Text("Data de Nascimento: " + "\(userCompleto.userFullL?.dateOfBirth ?? "Not found")")
                    Text("Telefone: " + "\(userCompleto.userFullL?.phone ?? "Not found")")
                    
                }
                Section(header: Text("Localização")) {
                    // Exibe informações detalhadas de localização do usuário.
                    Text("Rua: " + "\(userCompleto.userFullL?.location.street ?? "Not found")")
                    Text("Cidade: " + "\(userCompleto.userFullL?.location.city ?? "Not found")")
                    Text("Estado: " + "\(userCompleto.userFullL?.location.state ?? "Not found")")
                    Text("País: " + "\(userCompleto.userFullL?.location.country ?? "Not found")")
                    Text("Fuso Horário: " + "\(userCompleto.userFullL?.location.timezone ?? "Not found")")
                }
            }
        }
        .navigationTitle("Detalhes do Usuário")
    }
}

// A estrutura UserFull representa informações detalhadas de um usuário.
struct UserFull: Codable {
    
    var id: String
    var title: String
    var firstName: String
    var lastName: String
    var gender: String
    var email: String
    var dateOfBirth: String
    var registerDate: String
    var phone: String
    var picture: String
    var location: Location
}

// A estrutura Location representa informações de localização.
struct Location: Codable {
    
    var street: String
    var city: String
    var state: String
    var country: String
    var timezone: String
}

// A classe GetAllInfo é responsável por obter informações detalhadas do usuário.
class GetAllInfo: ObservableObject {
    
    @Published var userFullL: UserFull? // Armazena informações detalhadas do usuário.
    
    var id: String // ID do usuário a ser obtido.
    
    // Inicializador que recebe o ID do usuário.
    init(id: String) {
        self.id = id
        self.getUserFull() // Obtém informações detalhadas do usuário.
    }
    
    // Função para obter informações detalhadas do usuário com base no ID.
    func getUserFull() {
        
        // Cria a URL para a solicitação.
        guard let url = URL(string: "https://dummyapi.io/data/v1/user/" + self.id) else {
            print("Invalid URL")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET" // Define o método HTTP como GET.
        urlReq.setValue("650c6c418b4bf3bfbaef1ca9", forHTTPHeaderField: "app-id") // Define a chave de API no cabeçalho.
        
        URLSession.shared.dataTask(with: urlReq) { data, _, error in
            if let error = error {
                print("Error in request: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty or missing data in the response.")
                return
            }
            if let userFull = try? JSONDecoder().decode(UserFull.self, from: data) {
                DispatchQueue.main.async {
                    self.userFullL = userFull
                }
            } else {
                print("Error decoding JSON: Data could not be decoded.")
            }
        }.resume() // Inicia a tarefa de solicitação.
        
    }
    
    // Função para atualizar informações do usuário (não utilizada neste código).
    func updateUser() {
        
        // Cria a URL para a solicitação.
        guard let url = URL(string: "https://dummyapi.io/data/v1/user/" + self.id) else {
            print("URL inválida")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "PUT" // Define o método HTTP como PUT.
        urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type") // Define o tipo de conteúdo como JSON.
        urlReq.setValue("650c6c418b4bf3bfbaef1ca9", forHTTPHeaderField: "app-id") // Define a chave de API no cabeçalho.
        
        do {
            let jsonData = try JSONEncoder().encode(userFullL)
            urlReq.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: urlReq) { data, response, error in
                if let error = error {
                    print("Erro ao atualizar o usuário: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            print("Contato atualizado:")
                            print("ID:", jsonResponse["id"] ?? "")
                            print("Nome:", jsonResponse["firstName"] ?? "", jsonResponse["lastName"] ?? "")
                        }
                    } catch {
                        print("Erro ao analisar a resposta: \(error)")
                    }
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Erro ao atualizar o contato: \(httpResponse.statusCode)")
                    }
                    if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                        print("Detalhes do erro: \(responseString)")
                    }
                }
            }
            
            task.resume() // Inicia a tarefa para fazer a solicitação de atualização.
        } catch {
            print("Erro ao serializar os dados JSON: \(error)")
        }
    }
    
}
