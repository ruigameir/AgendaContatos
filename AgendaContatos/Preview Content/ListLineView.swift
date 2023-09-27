//
//  ListLineView.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation
import SwiftUI

struct ListLineView: View{
    
    var user:user
    
    var body: some View{
        
        HStack{

//            Image(contato.foto)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .clipShape(Ellipse())
                        
            Text(user.firstName)
                .font(.title)
                .fontWeight(.bold)
            Text(user.lastName)
                .font(.title)
                .fontWeight(.bold)

            }
        }
    }


