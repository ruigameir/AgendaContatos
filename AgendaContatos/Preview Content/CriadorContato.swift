//
//  CriadorContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 25/09/2023.
//

import Foundation
import SwiftUI

struct CriadorContato: View{
    
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
    
    @StateObject var criar = CriarUser()
    
    var body: some View{
        
        VStack{
            Form{
                Section(header: Text("Informações Pessoais")) {
                    TextField("Título", text: $title)
                    TextField("Primeiro Nome", text: $firstName)
                    TextField("Sobrenome", text: $lastName)
                    TextField("Genero", text: $gender)
                    TextField("URL da Foto", text: $picture)
                    TextField("Email", text: $email)
                    TextField("Data de Nascimento", text: $dateOfBirth)
                    TextField("Telefone", text: $phone)
                }
                
                Section(header: Text("Localização")) {
                    TextField("Rua", text: $street)
                    TextField("Cidade", text: $city)
                    TextField("Estado", text: $state)
                    TextField("País", text: $country)
                    TextField("Fuso Horário", text: $timezone)
                    
                    Button (action: {
                        
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
                        
                        criar.create_user()
                        
                        // Após criar o usuário com sucesso, volte para a ContentView
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Criar")
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
 
            }
  
        }
        
        .navigationTitle("Crie um contato")
        
    }
}


class CriarUser: ObservableObject {
    
    let url: URL
    let apiKey: String
    
    @Published var data: [String: Any] = [
        "title": "",
        "firstName": "",
        "lastName": "",
        "picture": "",
        "gender":"",
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
