//
//  ShoppingListViewModel.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/5/23.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingListViewModel {
    
    var data = ["그립톡 구매하기", "사이다 구매하기", "아이패드 케이스 최저가 알아보기", "양말"]
    lazy var items = BehaviorSubject(value: data)
    let disposeBag = DisposeBag()
    
    
    
}
