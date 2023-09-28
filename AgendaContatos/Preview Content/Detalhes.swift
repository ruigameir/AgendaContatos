//
//  Detalhes.swift
//  AgendaDeContatos
//
//  Created by Bruno Silva on 28/09/2023.
//

import Foundation
import SwiftUI

struct Detalhes: View {
    var user: User
    @ObservedObject var userCompleto: GetAllInfo
    
    init(user: User) {
        self.user = user
        self.userCompleto = GetAllInfo(id: user.id)
        userCompleto.getUserFull()
    }
    
    var body: some View {
        VStack {
            Form{
                Section("Informações do Usuário"){
                    Text("Nome: " + "\(userCompleto.userFullL?.title ?? "Not found")" + " " + "\(userCompleto.userFullL?.firstName ?? "Not found") \(userCompleto.userFullL?.lastName ?? "Not found")")
                    Text("Género: " + "\(userCompleto.userFullL?.gender ?? "Not found")")
                    Text("E-mail: " + "\(userCompleto.userFullL?.email ?? "Not found")")
                    Text("Data de Nascimento: " + "\(userCompleto.userFullL?.dateOfBirth ?? "Not found")")
                    Text("Telefone: " + "\(userCompleto.userFullL?.phone ?? "Not found")")
                    
                }
                Section(header: Text("Localização")) {
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

struct UserFull: Codable {
    
    let id: String
    let title: String
    let firstName: String
    let lastName: String
    let gender: String
    let email: String
    let dateOfBirth: String
    let registerDate: String
    let phone: String
    let picture: String
    let location: Location
}

struct Location: Codable {
    
    let street: String
    let city: String
    let state: String
    let country: String
    let timezone: String
}

class GetAllInfo: ObservableObject {
    
    @Published var userFullL: UserFull?
    
    var id: String
    
    init(id:String) {
        self.id = id
        
    }
    
    func getUserFull() {
        
        guard let url = URL(string: "https://dummyapi.io/data/v1/user/" + self.id) else {
            print("Invalid URL")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.setValue("650c6c418b4bf3bfbaef1ca9", forHTTPHeaderField: "app-id")
        
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
        }.resume()
    }
}
