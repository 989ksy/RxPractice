//
//  LoginValidationViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/13/23.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginValidationViewController : UIViewController {

    let disposeBag = DisposeBag()
    let viewModel = LoginValidationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
        bind()

    }



    //MARK: - bind
    
    func bind() {
        
        let input = LoginValidationViewModel.Input(login: loginTextfield.rx.text.orEmpty, password: passwordTextfield.rx.text.orEmpty, tap: nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)

        let validation = Observable.combineLatest(input.login, input.password) { login, password in
            return login.count >= 6 && password.count >= 8
        }

        validation
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        validation
            .subscribe(with: self) { owner, value in
                owner.nextButton.backgroundColor = value ? UIColor.green : UIColor.red
                owner.loginTextfield.backgroundColor = value ? UIColor.white : UIColor.gray
                owner.passwordTextfield.backgroundColor = value ? UIColor.white : UIColor.gray
            }
            .disposed(by: disposeBag)

        output.tap
            .subscribe(with: self) { owner, value in
                print("tapped")
            }
            .disposed(by: disposeBag)





    }
    
    
    //MARK: - Configure UI
        
        let loginTextfield = {
            
            let view = UITextField()
            view.placeholder = "6글자 이상의 아이디를 입력하세요."
            view.borderStyle = .line
            view.textColor = .black
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 1
            view.clipsToBounds = true
            return view
            
        }()
        
        let passwordTextfield = {
            let view = UITextField()
            view.placeholder = "8글자 이상의 비밀번호를 입력하세요."
            view.borderStyle = .line
            view.textColor = .black
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 1
            view.clipsToBounds = true
            return view
        }()
        
        let nextButton = {
            let view = UIButton()
            view.setTitle("로그인", for: .normal)
            view.backgroundColor = .brown
            view.layer.cornerRadius = 20
            return view
        }()
        
    func configure() {
        
        view.addSubview(loginTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(nextButton)
        
        loginTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(120)
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(loginTextfield.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        nextButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        
        
        
        
    }
    
    
    
    
}
