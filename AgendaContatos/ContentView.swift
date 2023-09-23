//
//  ContentView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var obj = CriadorObjetos()
    
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
            }
            
            .navigationBarTitle("Contatos")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing:
                Button(action: {
                    
                }) {
                Text("Add")
                Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            )
        }
    }
}
