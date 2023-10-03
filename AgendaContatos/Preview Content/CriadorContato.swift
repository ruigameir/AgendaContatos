//
//  CriadorContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 25/09/2023.
//

import Foundation
import SwiftUI

struct CriadorContato: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
    
    @State private var errorMessage: String = ""
    
    @State private var showAlert = false // Estado para controlar a exibição do alerta
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
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
                    TextField("Fuso Horário", text: $timezone)
                    
                    Button(action: {
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
                        
                        criar.create_user { result in
                            switch result {
                            case .success:
                                // Usuário criado com sucesso, limpe a mensagem de erro
                                alertTitle = "Sucesso"
                                alertMessage = "Contato criado com sucesso."

                            case .failure(let error):
                                // Atualize a mensagem de erro com base no erro
                                alertTitle = "Erro"
                                alertMessage = "Erro ao criar o usuário: \(error.localizedDescription)"
                                
                            }
                            showAlert = true
                        }
                        
                    }, label: {
                        Text("Criar")
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    
                    
                }
                // Use o modificador 'alert' para exibir o alerta quando 'showAlert' for verdadeiro
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                        self.presentationMode.wrappedValue.dismiss()

                    }))
                }
                
                
            }
        }
        .navigationTitle("Crie um contato")
    }
}

class CriarUser: ObservableObject {
    
    let url: URL
    let apiKey: String
    
    @Published var errorMessage: String = ""
    
    
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
        self.url = URL(string: "https://dummyapi.io/data/v1/user/create")!
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
    }
    
    func create_user(completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "app-id")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro ao criar o usuário: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   (200..<300).contains(httpResponse.statusCode) {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            print("Usuário criado:")
                            print("ID:", jsonResponse["id"] ?? "")
                            print("Nome:", jsonResponse["firstName"] ?? "", jsonResponse["lastName"] ?? "")
                        }
                        completion(.success(()))
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
                        print("Detalhes do erro: \(responseString)")
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: responseString])))
                    }
                }
            }
            
            task.resume()
        } catch {
            print("Erro ao serializar os dados JSON: \(error)")
            completion(.failure(error))
        }
    }
}
