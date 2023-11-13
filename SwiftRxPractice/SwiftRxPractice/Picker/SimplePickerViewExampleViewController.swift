//
//  SimplePickerViewExampleViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 10/31/23.
//

import UIKit
import RxSwift
import RxCocoa

final class SimplePickerViewExampleViewController: ViewController {
    
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    
    let disposeBag = DisposeBag()
    let viewModel = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //피커뷰에 보여주기_ pickerView1
        Observable.just([1,2,3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)" // 픽커뷰에 어떻게 나올지
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe  { models in
                print("models selected 1 : \(models)")
            }
            .disposed(by: disposeBag)
        
        //피커뷰 item 꾸미기_ pickerView2
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in return NSAttributedString(string: "\(item)",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.cyan,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
            ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected 2: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe { models in
                print("models selected 3: \(models)")
            }
            .disposed(by: disposeBag)
    }
    
}
