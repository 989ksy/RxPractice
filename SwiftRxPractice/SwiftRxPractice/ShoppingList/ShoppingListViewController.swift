//
//  ShoppingListViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/3/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TransitionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "화면전환 \(Int.random(in: 1...100))"
    }
    
}

class ShoppingListViewController: UIViewController {
    
    let searchbar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.searchTextField.placeholder = "무엇을 구매하실 건가요?"
        view.searchTextField.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        view.tintColor = .systemGray6
        view.layer.cornerRadius = 10
        view.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        view.searchTextField.borderStyle = .none
        return view
    }()
    let addButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    let tableview = {
        let view = UITableView()
        view.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        view.rowHeight = 60
        view.separatorStyle = .singleLine
        return view
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = ShoppingListViewModel()
    
    let addButtonIstapped = BehaviorSubject(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        title = "쇼핑"
        
        setHierarchy()
        configureLayout()
        bind()
        
    }
    
    func bind() {
        
        viewModel.items
            .bind(to: tableview.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) {
                (row, element, cell) in
                cell.listLabel.text = element
                cell.checkButton.tintColor = .black
                cell.favoriteButton.tintColor = .black
                cell.backgroundColor = .systemGray6
                cell.checkButton.rx.tap
                    .subscribe(with: self) { owner, value in
                        let ischecked = owner.viewModel.checkButtonState.value
                        let updatedState = ischecked ? "checkmark.square" : "checkmark.square.fill"
                        cell.checkButton.setImage(UIImage(systemName: updatedState), for: .normal)
                        owner.viewModel.checkButtonState.accept(!ischecked)
                    }
                    .disposed(by: cell.disposeBag)
            
                cell.favoriteButton.rx.tap
                    .subscribe(with: self) { owner, value in
                        let isFavorite = owner.viewModel.favoriteButtonState.value
                        let updatedState = isFavorite ? "star" : "star.fill"
                        cell.favoriteButton.setImage(UIImage(systemName: updatedState), for: .normal)
                        owner.viewModel.favoriteButtonState.accept(!isFavorite)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableview.rx.itemSelected, tableview.rx.modelSelected(String.self))
            .subscribe(with: self) { owner, value in
                let vc = TransitionViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        tableview.rx.itemDeleted
            .subscribe(with: self, onNext: { owner, indexPath in
                let row = indexPath.row
                owner.viewModel.data.remove(at: row)
                owner.viewModel.items.onNext(owner.viewModel.data)
            })
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withLatestFrom(searchbar.rx.text.orEmpty) { void, text in return text }
            .subscribe(with: self) { owner, text in
                owner.viewModel.data.insert(text, at: 0)
                owner.viewModel.items.onNext(owner.viewModel.data)
            }
            .disposed(by: disposeBag)
        
        searchbar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                let result = value == "" ? owner.viewModel.data : owner.viewModel.data.filter{ $0.contains(value)}
                owner.viewModel.items.onNext(result)
                
                print("===== 검색: \(value)")
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    //MARK: - configure hierarchy & layout
    
    func setHierarchy() {
        view.addSubview(searchbar)
        searchbar.addSubview(addButton)
        view.addSubview(tableview)
    }
    func configureLayout() {
        searchbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(60)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.top).offset(12)
            make.trailing.equalTo(searchbar.snp.trailing).inset(15)
            make.bottom.equalTo(searchbar.snp.bottom).inset(12)
            make.width.equalTo(60)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    
}

