//
//  NumbViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/3/23.
//

import UIKit
import RxSwift
import RxCocoa

class NumbViewController : ViewController {
    
    @IBOutlet var number1: UITextField!
    @IBOutlet var number2: UITextField!
    @IBOutlet var number3: UITextField!
    
    @IBOutlet var result: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                    return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
                }
                .map { $0.description }
                .bind(to: result.rx.text)
                .disposed(by: disposeBag)
        
        
       
    }
    
    
    
}
