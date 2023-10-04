//
//  CriadorContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 25/09/2023.
//

import Foundation
import SwiftUI

struct CriadorContato: View {
    
    @Environment(\.presentationMode) var presentationMode // Acede ao modo de apresentação
    
    // Estados para armazenar os dados do novo contato
    @State private var title: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var picture: String = ""
    @State private var gender: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: String = ""
    @State private var phone: String = ""
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var country: String = ""
    @State private var timezone: String = ""
    
    // Estados para controlar a exibição do alerta
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // Uma instância da classe CriarUser para criar um usuário
    @StateObject var criar = CriarUser()
    
    var body: some View {
        
        VStack {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    TextField("Título", text: $title)
                    TextField("Primeiro Nome", text: $firstName)
                    TextField("Sobrenome", text: $lastName)
                    TextField("Genero", text: $gender)
                    TextField("URL da Foto", text: $picture)
                    TextField("Email", text: $email)
                    TextField("Data de Nascimento (MM/DD/AAAA)", text: $dateOfBirth)
                    TextField("Telefone", text: $phone)
                }
                
                Section(header: Text("Localização")) {
                    TextField("Rua", text: $street)
                    TextField("Cidade", text: $city)
                    TextField("Estado", text: $state)
                    TextField("País", text: $country)
                    TextField("Fuso Horário (+H:HH)", text: $timezone)
                    
                    Button(action: {
                        // Preenche os dados do novo usuário com base nos estados
                        criar.data["title"] = title
                        criar.data["firstName"] = firstName
                        criar.data["lastName"] = lastName
                        criar.data["picture"] = picture
                        criar.data["gender"] = gender
                        criar.data["email"] = email
                        criar.data["dateOfBirth"] = dateOfBirth
                        criar.data["phone"] = phone
                        criar.data["location"] = [
                            "street": street,
                            "city": city,
                            "state": state,
                            "country": country,
                            "timezone": timezone
                        ]
                        
                        // Chama a função para criar o usuário
                        criar.create_user { result in
                            switch result {
                            case .success:
                                // Usuário criado com sucesso, define a mensagem de sucesso
                                alertTitle = "Sucesso"
                                alertMessage = "Contato criado com sucesso."
                                
                            case .failure(let error):
                                // Atualiza a mensagem de erro com base no erro ocorrido
                                alertTitle = "Erro"
                                alertMessage = "Erro ao criar o usuário: \(error.localizedDescription)"
                                
                            }
                            showAlert = true // Exibe o alerta após a criação do usuário
                        }
                        
                    }, label: {
                        Text("Criar")
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    
                    
                }
                // Use o modificador 'alert' para exibir o alerta quando 'showAlert' for verdadeiro
                .alert(isPresented: $showAlert) {
                    if alertTitle == "Sucesso"{
                        // Se o título do alerta for "Sucesso", crie um Alert com um botão "OK" que fecha a tela
                        return Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }))
                    }
                    else{
                        // Se o título do alerta não for "Sucesso", crie um Alert com um botão "OK" que não faz nada além de fechar o alerta
                        return Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        .navigationTitle("Crie um contato")
    }
}

// Classe para criar um novo usuário
class CriarUser: ObservableObject {
    
    let url: URL
    let apiKey: String
    
    // Dicionário para armazenar os dados do novo usuário
    @Published var data: [String: Any] = [
        "title": "",
        "firstName": "",
        "lastName": "",
        "picture": "",
        "gender": "",
        "email": "",
        "dateOfBirth": "",
        "phone": "",
        "location": [
            "street": "",
            "city": "",
            "state": "",
            "country": "",
            "timezone": ""
        ],
        "registerDate": "",
        "updatedDate": ""
    ]
    
    init() {
        self.url = URL(string: "https://dummyapi.io/data/v1/user/create")! // URL da API de criação de usuário
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
    }
    
    // Função para criar um novo usuário na API
    func create_user(completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Define o método HTTP como POST
        request.setValue(apiKey, forHTTPHeaderField: "app-id") // Define a chave de API no cabeçalho da solicitação
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Define o tipo de conteúdo como JSON
        
        do {
            // Serializa os dados do dicionário 'data' em formato JSON
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = jsonData // Serializa os dados do dicionário 'data' em formato JSON
            
            // Cria uma tarefa de sessão de URL para realizar a solicitação
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro ao criar o usuário: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   (200..<300).contains(httpResponse.statusCode) {
                    // Se a resposta HTTP estiver no intervalo de sucesso (200-299)
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            print("Usuário criado:")
                            print("ID:", jsonResponse["id"] ?? "")
                            print("Nome:", jsonResponse["firstName"] ?? "", jsonResponse["lastName"] ?? "")
                        }
                        completion(.success(())) // Usuário criado com sucesso
                    } catch {
                        print("Erro ao analisar a resposta: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Erro ao criar o usuário: \(httpResponse.statusCode)")
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)))
                    }
                    if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                        // Se a resposta não estiver no intervalo de sucesso, imprime detalhes do erro
                        print("Detalhes do erro: \(responseString)")
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: responseString])))
                    }
                }
            }
            
            task.resume() // Inicia a tarefa para fazer a solicitação
        } catch {
            // Em caso de erro na serialização dos dados JSON
            print("Erro ao serializar os dados JSON: \(error)")
            completion(.failure(error))
        }
    }
}
