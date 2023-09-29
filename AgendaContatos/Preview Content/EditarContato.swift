//
//  EditarContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 29/09/2023.
//

import Foundation

import SwiftUI

struct EditarContato: View {
    var user : User
    
    @State private var title: String = "ms"
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
    
    var body: some View{
        VStack{
            Form{
                Section(header: Text("Informações Pessoais")) {
                    TextField("Título", text: $title)
                    TextField("Primeiro Nome", text: $firstName)
                    TextField("Sobrenome", text: $lastName)
                    TextField("URL da Foto", text: $picture)
                    TextField("Genero", text: $gender)
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
                }
            }
        }
    }
}
