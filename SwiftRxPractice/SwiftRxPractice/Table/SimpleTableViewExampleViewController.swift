////
////  SimpleTableViewExampleViewController.swift
////  SwiftRxPractice
////
////  Created by Seungyeon Kim on 10/31/23.
//////

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: ViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        let items = Observable.just(
            (0..<20).map{"\($0)"}
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
        
        
    }
    
    
}
