//
//  ValidationViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/3/23.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class ValidationViewController : UIViewController {
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var userValidLabel: UILabel!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!
    @IBOutlet var validCheckButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameTextfield.rx.text.orEmpty.map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextfield.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextfield.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameTextfield.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: usernameTextfield.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: validCheckButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validCheckButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
        
        func showAlert() {
            let alert = UIAlertController(
                title: "RxExample",
                message: "This is wonderful",
                preferredStyle: .alert
            )
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
    
}
