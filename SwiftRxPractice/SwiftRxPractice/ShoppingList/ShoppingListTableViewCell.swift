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
    
    let checkImage = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.square")?.withTintColor(.black)
        checkImage.contentMode = .scaleAspectFit
        checkImage.clipsToBounds = true
        return checkImage
    }()
    
    let favoriteIamge = {
        let favoriteIamge = UIImageView()
        favoriteIamge.image = UIImage(systemName: "star")?.withTintColor(.black)
        favoriteIamge.contentMode = .scaleAspectFit
        favoriteIamge.clipsToBounds = true
        return favoriteIamge
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
        
        contentView.addSubview(checkImage)
        contentView.addSubview(listLabel)
        contentView.addSubview(favoriteIamge)
        
        checkImage.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        listLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImage.snp.trailing).offset(15)
            make.centerY.equalTo(checkImage)
            make.trailing.equalTo(favoriteIamge.snp.leading).offset(-15)
        }
        favoriteIamge.snp.makeConstraints { make in
            make.centerY.equalTo(listLabel)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        
    }
    
    
}
