//
//  CriadorObjetos.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation

class CriadorObjetos:ObservableObject{
    
    var agenda:[Contato] = []
    
    init(agenda:[Contato] = []){
        self.agenda = agenda
        
        self.agenda.append(Contato(primeiroNome: "Rui", segundoNome: "Gameiro", foto: "foto1", email: "", telemovel: 910722243))
        self.agenda.append(Contato(primeiroNome: "String", segundoNome: "String", telemovel: 999))
  
        
    }
    
    
    
}
