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
    
    @State private var showingAlert = false // Um estado para controlar a exibição do alerta
    
    @Environment(\.presentationMode) var presentationMode // Acede o modo de apresentação
    
    // Cria uma instância de ApagarContato com o ID do usuário
    var apagar: ApagarContato {
        return ApagarContato(id: user.id)
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Exibe a imagem do usuário de forma assíncrona
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
            
            // Navega para a tela de detalhes do usuário
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
            
            // Navega para a tela de edição do usuário
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
            
            // Botão para apagar o usuário
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
        // Define o título da barra de navegação
        .navigationTitle("\(user.firstName) \(user.lastName)")
        
        // Alerta de confirmação para apagar o usuário
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmar exclusão"),
                message: Text("Você tem certeza de que deseja excluir este contato? Esta ação não pode ser desfeita."),
                primaryButton: .default(Text("Cancelar")),
                secondaryButton: .destructive(Text("Excluir"), action: {
                    print("ID do usuário a ser excluído: \(user.id)")
                    apagar.deleteUser()
                    self.presentationMode.wrappedValue.dismiss() // fecha a tela após a exclusao
                })
            )
        }
        
    }
}
