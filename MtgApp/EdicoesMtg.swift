//
//  EdicoesMtg.swift
//  MtgApp
//
//  Created by Wilson Divino on 13/12/15.
//  Copyright © 2015 Wilson Divino. All rights reserved.
//

import Foundation

class EdicoesMtg {
    
    var nome : String = ""
    var codigo : String = ""
    
    init( nome : String, codigo : String ){
        self.nome = nome
        self.codigo = codigo
    }
    
    func getNome() -> String {
        return self.nome
    }
    
    func getCodigo() -> String {
        return self.codigo
    }
    
}