//
//  ShoppingListTableViewCell.swift
//  SwiftRxPractice
//
//  Created by Seungyeon Kim on 11/4/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingListTableViewCell : UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    
    let listLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let checkButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let favoriteIamge = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(checkButton)
        contentView.addSubview(listLabel)
        contentView.addSubview(favoriteIamge)
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        listLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(15)
            make.centerY.equalTo(checkButton)
            make.trailing.equalTo(favoriteIamge.snp.leading).offset(-15)
        }
        favoriteIamge.snp.makeConstraints { make in
            make.centerY.equalTo(listLabel)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        
    }
    
    
}
