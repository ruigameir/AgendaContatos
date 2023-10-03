//
//  ContatoIndividual.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation
import SwiftUI


struct ContatoIndividual: View {
    
    var user: User
    
    @State private var showingAlert = false
    
    @State private var isEditadoAlert = false

    @Environment(\.presentationMode) var presentationMode
    
    var apagar: ApagarContato {
        return ApagarContato(id: user.id) // Passar o ID para ApagarContato
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            
            AsyncImage(url: URL(string: user.picture)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Ellipse())
                        .padding(.top, 20)
                default:
                    Image("noImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Ellipse())
                        .padding(.top, 20)
                    ProgressView()
                }
            }
            
            Text(user.firstName + " " + user.lastName)
                .font(.title)
                .fontWeight(.bold)
            
            NavigationLink(destination: Detalhes(user: user)){
                Text("Detalhes")
                    .foregroundColor(.blue)
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            }
            
            NavigationLink(destination: EditarContato(user: user)) {
                
                Text("Editar")
                    .foregroundColor(.green)
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 1)
                    )
            }
            
            Button(action: {
                showingAlert = true
                
            }) {
                Text("Apagar")
                    .foregroundColor(.red)
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
            
            Spacer() // Empurra os elementos para o centro da tela
            
        }
        .navigationTitle("\(user.firstName) \(user.lastName)")
        .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Confirmar exclusão"),
                        message: Text("Você tem certeza de que deseja excluir este contato? Esta ação não pode ser desfeita."),
                        primaryButton: .default(Text("Cancelar")),
                        secondaryButton: .destructive(Text("Excluir"), action: {
                            // Aqui, você pode chamar a função para excluir o usuário
                            print("ID do usuário a ser excluído: (user.id)")
                            apagar.deleteUser()
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    )
                }
        
    }
}



