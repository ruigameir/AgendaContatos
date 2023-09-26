//
//  ContentView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    //@StateObject var obj = CriadorObjetos()
    @State var load: loadData
    load.getData()
    @State var users: [user] = load.users
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<26, id: \.self) { charIndex in
                        let char = Character(UnicodeScalar(charIndex + 65)!)
                        Section(String(char)) {
                            ForEach(
                                obj.agenda.filter({ contato in
                                    if let primeiroNome = contato.primeiroNome.first{
                                        return primeiroNome.unicodeScalars.first?.value == char.unicodeScalars.first?.value
                                    }
                                    return false
                                })
                                
                            ) { contato in
                                NavigationLink(destination: ContatoIndividual(contato: contato)) {
                                    ListLineView(contato: contato)
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

