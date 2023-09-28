//
//  CriadorContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 25/09/2023.
//

import Foundation
import SwiftUI

struct CriadorContato: View{
    
    @State private var title: String = ""
    @State private var primeiroNome: String = ""
    @State private var ultimoNome: String = ""
    @State private var email: String = ""
    @State private var foto: String = ""
    
    @StateObject var criar = CriarUser()
    
    var body: some View{
        
        VStack{
            Form{
                Section("Nome"){
                    TextField("Titulo", text: $title)
                    TextField("Primeiro nome", text: $primeiroNome)
                    TextField("Último nome", text: $ultimoNome)
                    
                }
                Section("Fotografia"){
                    TextField("E-mail", text: $email)
                    TextField("URL Foto", text: $foto)

                    Button (action: {
                        criar.data["title"] = title
                        criar.data["firstName"] = primeiroNome
                        criar.data["lastName"] = ultimoNome
                        criar.data["email"] = email
                        criar.data["picture"] = foto
                        criar.create_user()
                        
                    }, label: {
                        Text("Criar")
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)

                }
                
                
            }
            
            .navigationTitle("Crie um contato")
            
        }
    }
}

class CriarUser: ObservableObject {
    
    let url: URL
    let apiKey: String
    
    var data = [
            "firstName": "",
            "lastName": "",
            "email": "" ,
            "title": "",
            "picture": ""
        ]
        
    init() {
        self.url = URL(string: "https://dummyapi.io/data/v1/user/create")!
        self.apiKey = "650c6c418b4bf3bfbaef1ca9"
    }
    
    func create_user() {
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
                    } catch {
                        print("Erro ao analisar a resposta: \(error)")
                    }
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Erro ao criar o usuário: \(httpResponse.statusCode)")
                    }
                    if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                        print("Detalhes do erro: \(responseString)")
                    }
                }
            }
            
            task.resume()
        } catch {
            print("Erro ao serializar os dados JSON: \(error)")
        }
    }
}
