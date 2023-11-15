//
//  IdValidationViewModel.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/16/23.
//

import Foundation
import RxSwift
import RxCocoa

class IdValidationViewModel {
    
    let emailValidationRelay = BehaviorSubject(value: "")
    let isVaild = BehaviorSubject(value: false)
    
    struct Input {
        var idInputText : ControlProperty<String>
        var tap : ControlEvent<Void>
    }
    
    struct Output {
        var tap : ControlEvent<Void>
    }
    
//    func transform (input: Input) -> Output {
//        
//        return Output
//    }
    
    
}
