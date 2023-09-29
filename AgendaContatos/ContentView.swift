//
//  ContentView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var load = LoadData()
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(alphabet, id: \.self) { char in
                        let filteredUsers = load.users
                            .filter { user in
                                guard let firstChar = user.firstName.first else {
                                    return false
                                }
                                return String(firstChar).uppercased() == char
                            }
                            .sorted { $0.firstName < $1.firstName } // Ordenar alfabeticamente
                        
                        Section(char) {
                            ForEach(filteredUsers) { user in
                                NavigationLink(destination: ContatoIndividual(user: user)){
                                    AsyncImage(url: URL(string: user.picture)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Ellipse())
                                        default:
                                            Image("noImg")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Ellipse())
                                            ProgressView()
                                        }
                                    }
                                    Text(user.firstName + " " + user.lastName)
                                        .fontWeight(.bold)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                    }
                }
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
                                Text("Add")
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
}
