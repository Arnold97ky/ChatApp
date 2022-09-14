//
//  ConversationTableViewCell.swift
//  GroupKit
//
//  Created by Arnold Sylvestre on 8/16/22.
//

import UIKit
import SDWebImage

class ConversationTableViewCell: UITableViewCell {
    
    static let identifier = "ConversationTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 50.0
        imageView.backgroundColor = .systemGray
        imageView.image = UIImage(named: "image")
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return imageView
    }()
    
    private let userNamelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    private let userMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       contentView.addSubview(userMessageLabel)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        self.backgroundColor = .systemMint
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillProportionally)
        let vStack = UIStackView(axis: .vertical, spacing: 8, distribution: .fillProportionally)
        vStack.addArrangedSubview(self.userNamelabel)
        vStack.addArrangedSubview(self.userMessageLabel)
        hStack.addArrangedSubview(self.userImageView)
        hStack.addArrangedSubview(vStack)
        self.contentView.addSubview(hStack)
        hStack.bindToSuperView()
     
    }
    
 
    public func configure(with model: Conversation) {
        
        self.userMessageLabel.text = model.latestMessage.text
        self.userNamelabel.text = model.name
        
        let path = "images/\(model.otherUserEmail)_profile_picture.png"
        StorageManager.shared.downloadURL(for: path, completion: {[weak self] result in
            switch result {
            case .success(let url):
                
                DispatchQueue.main.async {
                    self?.userImageView.sd_setImage(with: url, completed:  nil )
                }
                
            case .failure(let error):
                print("failed to get image url: \(error)")
            }
        })
        
    }
}

