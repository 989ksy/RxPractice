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

struct ShoppingItem {
    var title: String
    var isFavorite: Bool
    var isChecked: Bool
}

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
    
    let favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureCell (item: ShoppingItem) {
        listLabel.text = item.title
        checkButton.tintColor = .black
        favoriteButton.tintColor = .black
        checkButton.setImage(UIImage(systemName: item.isChecked ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: item.isFavorite ? "star.fill" : "star"), for: .normal)
    }
    
    private func configure() {
        
        contentView.addSubview(checkButton)
        contentView.addSubview(listLabel)
        contentView.addSubview(favoriteButton)
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        listLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(15)
            make.centerY.equalTo(checkButton)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-15)
        }
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(listLabel)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        
    }
    
    
}
