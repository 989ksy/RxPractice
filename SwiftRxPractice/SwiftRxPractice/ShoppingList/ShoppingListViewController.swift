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
    
    var data = ["그립톡 구매하기", "사이다 구매하기", "아이패드 케이스 최저가 알아보기", "양말"]
    
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
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
        
        items
            .bind(to: tableview.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) {
                (row, element, cell) in
                
                cell.listLabel.text = element
                cell.checkImage.tintColor = .black
                cell.favoriteIamge.tintColor = .black
                cell.backgroundColor = .systemGray6
            }
        
        
        
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
