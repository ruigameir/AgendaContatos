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
                .frame(width: 50, height: 50)
                .clipShape(Ellipse())
                        
            Text(contato.primeiroNome)
                .font(.title)
                .fontWeight(.bold)
            Text(contato.segundoNome)
                .font(.title)
                .fontWeight(.bold)

            }
        }
    }


