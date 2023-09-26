//
//  CriadorContato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 25/09/2023.
//

import Foundation
import SwiftUI

struct CriadorContato: View{
    
    @State private var primeiroNome: String = ""
    
    var body: some View{
        
        VStack{
            TextField("Primeiro nome: ", text: $primeiroNome)
        }
    }
}
