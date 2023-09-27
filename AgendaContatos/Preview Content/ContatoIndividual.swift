//
//  ContatoIndividual.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation
import SwiftUI


struct ContatoIndividual: View {
    
    var user: user
    
    
    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string: user.picture)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Ellipse())
                        .padding(.top, 20)
                default:
                    Image("noImg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Ellipse())
                        .padding(.top, 20)
                    ProgressView()
                }
            }
                     
 
            
            Text(user.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
                .padding(.top,20)
            
            Text(user.firstName)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
                .padding(.top,20)
            
            Text(user.lastName)
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
        .navigationTitle("\(user.firstName) \(user.lastName)")
        
        
        
        
    }
}

