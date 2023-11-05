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
    
    var data : [ShoppingItem] = [ShoppingItem(title: "그립톡 구매하기", isFavorite: false, isChecked: false), ShoppingItem(title: "사이다 구매하기", isFavorite: false, isChecked: false),ShoppingItem(title: "아이패드 케이스 최저가 알아보기", isFavorite: false, isChecked: false), ShoppingItem(title: "양말", isFavorite: false, isChecked: false) ]
    
    lazy var items = BehaviorSubject(value: data)

    let disposeBag = DisposeBag()
    
    init() {
        
        
        
        
        
    }
    
}
