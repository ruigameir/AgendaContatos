//
//  ListLineView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation
import SwiftUI

struct ListLineView: View{
    
    var contato:Contato
    
    var body: some View{
        
        HStack{
            Image(contato.foto)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.horizontal, 15)
                        
            Text(contato.primeiroNome)
                .font(.title)
                .fontWeight(.bold)
            Text(contato.segundoNome)
                .font(.title)
                .fontWeight(.bold)
            }
        }
    }


