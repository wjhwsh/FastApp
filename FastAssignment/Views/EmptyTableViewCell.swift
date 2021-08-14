//
//  EmptyTableViewCell.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "EmptyTableViewCell"
    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        self.contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate(
            [messageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
             messageLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
             messageLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
             messageLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 50)
            ]
            
        )
    }
}
