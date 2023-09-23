//
//  ContatoIndividual.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation
import SwiftUI


struct ContatoIndividual: View {
   
    var contato: Contato
    
    
    var body: some View {
        
        VStack{

            
            Image(contato.foto)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Ellipse())
                .padding(.top, 20)

            Text(contato.email)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
                .padding(.top,20)
         
            Spacer()
            NavigationLink {
                Text("Detalhes")
            } label: {
                Text("Mais info")
            }

        }
        .navigationTitle("\(contato.primeiroNome) \(contato.segundoNome)")
        
        
        
        
    }
}

