//
//  ViewController.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 10/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ShoppingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func shoppingButtonTapped(_ sender: Any) {
        
        let vc = ShoppingListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}




