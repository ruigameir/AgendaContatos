//
//  Contato.swift
//  AgendaContatos
//
//  Created by Rui Gameiro on 23/09/2023.
//

import Foundation

class Contato:Identifiable{
    
    var id = UUID()
    var primeiroNome:String
    var segundoNome:String
    private var _foto:String?
    private var _email:String?
    var telemovel: Int
    
    
    var foto:String{
        _foto ?? "noImg"
    }
    
    var email:String{
        _email ?? "Sem e-mail"
    }
    
    init(primeiroNome: String, segundoNome: String, foto: String? = nil, email: String? = nil, telemovel: Int) {
        self.primeiroNome = primeiroNome
        self.segundoNome = segundoNome
        self._foto = foto
        self._email = email
        self.telemovel = telemovel
    }
  
    
}
