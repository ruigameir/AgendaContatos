//
//  File.swift
//  AgendaDeContatos
//
//  Created by Bruno Silva on 28/09/2023.
//

import Foundation
import SwiftUI

struct EditarContato: View {
    
    var user: User
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var userCompleto: GetAllInfo
    
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
    
    @State private var isEditado = false
    
    init(user: User) {
        self.user = user
        self.userCompleto = GetAllInfo(id: user.id)
    }
    
    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Informações Pessoais")) {
                    HStack {
                        Text("\(userCompleto.userFullL?.title ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Título", text: $title)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.firstName ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Primeiro Nome", text: $firstName)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.lastName ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Último Nome", text: $lastName)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.gender ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Género", text: $gender)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.email ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Email", text: $email)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.dateOfBirth ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Data de Nascimento", text: $dateOfBirth)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.phone ?? "Not found") ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Telemóvel", text: $phone)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    
                }
                
                Section(header: Text("Localização")) {
                    HStack {
                        Text("\(userCompleto.userFullL?.location.street ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        TextField("Rua", text: $street)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.location.city ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Cidade", text: $city)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.location.state ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Estado", text: $state)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.location.country ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("País", text: $country)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("\(userCompleto.userFullL?.location.timezone ?? "Not found")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        TextField("Fuso Horário", text: $timezone)
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    
                    
                    
                    
                    Button (action: {
                        if (!title.isEmpty){userCompleto.userFullL?.title = title}
                        if (!firstName.isEmpty){userCompleto.userFullL?.firstName = firstName}
                        if (!lastName.isEmpty){userCompleto.userFullL?.lastName = lastName}
                        if (!gender.isEmpty){userCompleto.userFullL?.gender = gender}
                        if (!email.isEmpty){userCompleto.userFullL?.email = email}
                        if (!dateOfBirth.isEmpty){userCompleto.userFullL?.dateOfBirth = dateOfBirth}
                        if (!phone.isEmpty){userCompleto.userFullL?.phone = phone}
                        if (!street.isEmpty){userCompleto.userFullL?.location.street = street}
                        if (!city.isEmpty){userCompleto.userFullL?.location.city = city}
                        if (!state.isEmpty){userCompleto.userFullL?.location.state = state}
                        if (!country.isEmpty){userCompleto.userFullL?.location.country = country}
                        if (!timezone.isEmpty){userCompleto.userFullL?.location.timezone = timezone }
                        
                        userCompleto.updateUser()
                        isEditado = true
                        
                        
                    }, label:{
                        Text("Save")
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    
                    
                }
            }
        }
        .alert(isPresented: $isEditado) {
            Alert(title: Text("Sucesso"), message: Text("Contato Editado com sucesso. Regresse à página principal para ver o contato atualizado"), dismissButton: .default(Text("OK"), action: {
                // Aqui, você pode chamar a função para excluir o usuário
                print("ID do usuário a ser editado: (user.id)")
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}
