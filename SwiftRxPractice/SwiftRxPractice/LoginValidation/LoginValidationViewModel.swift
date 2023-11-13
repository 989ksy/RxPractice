//
//  LoginValidationViewModel.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/13/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginValidationViewModel {
    
    struct Input {
        let login : ControlProperty<String>
        let password : ControlProperty<String>
        let tap : ControlEvent<Void>
    }
    
    struct Output {
        let tap : ControlEvent<Void>
    }
    
    func transform (input: Input) -> Output {
        
        return Output(tap: input.tap)
        
    }
    
}
