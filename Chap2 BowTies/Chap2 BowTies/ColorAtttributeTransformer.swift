//
//  ColorAtttributeTransformer.swift
//  Chap2 BowTies
//
//  Created by Dmitry on 05.08.2021.
//

import UIKit

class ColorAtttributeTransformer: NSSecureUnarchiveFromDataTransformer {

    //1
    override class var allowedTopLevelClasses: [AnyClass] {
        [UIColor.self]
    }
    
    //2
    static func register() {
        let className = String(describing: ColorAtttributeTransformer.self)
        let name = NSValueTransformerName(className)
        
        let transormer = ColorAtttributeTransformer()
        ValueTransformer.setValueTransformer(transormer, forName: name)
    }
}

//MARK: - comments
/*
 1. Переопределите allowedTopLevelClasses, чтобы он возвращал список классов, которые может декодировать этот преобразователь данных. Мы хотим сохранить и получить экземпляры UIColor, поэтому здесь мы возвращаем массив, содержащий только этот класс.
 2. Как следует из названия, статическая функция register () помогает зарегистрировать подкласс с помощью ValueTransformer. Но зачем вам это делать? ValueTransformer поддерживает сопоставление «ключ-значение», где ключ - это имя, которое вы указываете с помощью NSValueTransformerName, а значение - это экземпляр соответствующего преобразователя. Это сопоставление понадобится вам позже в редакторе модели данных.
 */
