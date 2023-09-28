//
//  ContentView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    //@StateObject var obj = CriadorObjetos()
    @ObservedObject var load = loadData()
   
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<26, id: \.self) { charIndex in
                        let char = Character(UnicodeScalar(charIndex + 65)!)
                        let filteredUsers = load.users.filter { user in
                            guard let firstChar = user.firstName.first else {
                                return false
                            }
                            return String(firstChar).uppercased() == String(char)
                        }
                        
                        Section(String(char)) {
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


