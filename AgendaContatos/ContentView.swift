//
//  ContentView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    // Instância do objeto observado para carregar dados
    @ObservedObject var load = LoadData()
    
    // Estado para controlar o indicador de atualização
    @State private var isRefreshing = true
    
    // Array de letras do alfabeto
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
        
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(alphabet, id: \.self) { char in
                        // Filtrar usuários cujos nomes começam com a letra atual
                        let filteredUsers = load.users
                            .filter { user in
                                guard let firstChar = user.firstName.first else {
                                    return false
                                }
                                return String(firstChar).uppercased() == char
                            }
                            .sorted { $0.firstName < $1.firstName } // Ordenar alfabeticamente
                        // Criar uma seção para cada letra
                        Section(char) {
                            ForEach(filteredUsers) { user in
                                NavigationLink(destination: ContatoIndividual(user: user)){
                                    // Exibir uma imagem assíncrona do usuário
                                    AsyncImage(url: URL(string: user.picture)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Ellipse())
                                        default:
                                            // Exibir uma imagem padrão quando o usuario nao passar foto
                                            Image("noImg")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Ellipse())
                                            ProgressView()
                                        }
                                    }
                                    // Exibir o nome completo do usuário
                                    Text(user.firstName + " " + user.lastName)
                                        .fontWeight(.bold)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                    }
                }
                // Adicionar a capacidade de atualizar os dados deslizando para baixo
                .refreshable {
                    load.updateData()
                }
                // Quando a vista aparece, verificar se é necessário atualizar os dados
                .onAppear {
                    if(!isRefreshing){
                        Task {
                            // Atualizar os dados quando a vista aparecer
                            load.updateData()
                        }
                    }
                    isRefreshing = false
                }
            }
            // Configuração da barra de navegação
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Contatos")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 25)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: CriadorContato()) {
                            Text("Adicionar")
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 25)
                }
            }
        }
        
    }
}

