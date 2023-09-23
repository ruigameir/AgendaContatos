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
        NavigationView{
            
            VStack{
                
                List{
                    ForEach(obj.agenda){ ct in
                        
                        NavigationLink {
                        } label: {
                        ListLineView(contato: ct)
                        }
                    }
                }//list
                
            }
            
            .navigationTitle("Contatos")
            .navigationBarTitleDisplayMode(.automatic)
        }
        
    }
}
