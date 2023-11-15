//
//  IdValidationViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/16/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol IdValidationAttributed {
    func bind()
    func congfigure()
}

class IdValidationViewController : UIViewController {
    
    //MARK: - UI
    
    private let idTextfield = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "이메일을 입력해주세요."
        return view
    }()
    
    private let nextButton = {
        let view = UIButton()
        view.setTitle("Next", for: .normal)
        view.backgroundColor = .brown
        return view
    }()
    
    //MARK: - Methods
    
    private let viewModel = IdValidationViewModel()
    private let disposeBag = DisposeBag()
    
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind()
        configure()
    }
    
    //MARK: - Bind
    
    func bind() {
        
        let input = IdValidationViewModel.Input(idInputText: idTextfield.rx.text.orEmpty)
        
        viewModel.emailValidationRelay
            .bind(to: idTextfield.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isVaild
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        input.idInputText
            .map { $0.contains("@") && $0.count >= 8 }
            .subscribe(with: self) { owner, bool in
                owner.idTextfield.textColor = bool ? UIColor.black : UIColor.red
//                owner.nextButton.backgroundColor = bool ? UIColor.black : UIColor.lightGray
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(with: self) { owner, bool in
                print("tapped, 화면전환")
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    //MARK: - configure layouts

    func configure() {
        
        view.addSubview(idTextfield)
        view.addSubview(nextButton)
        
        idTextfield.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        nextButton.snp.makeConstraints{
            $0.top.equalTo(idTextfield.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        
    }
    
    
}
