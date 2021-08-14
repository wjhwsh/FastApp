//
//  OMDBTableViewCell.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import UIKit

class OMDBTableViewCell: UITableViewCell {
    static let reuseIdentifier = "OMDBTableViewCell"
    let stackView = UIStackView()
    
    let textStack = UIStackView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let imdbIDLabel = UILabel()
    let typeLabel = UILabel()
    
    let posterImageView = UIImageView()
    
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
        self.accessoryType = selected ? .checkmark : .none
        // Configure the view for the selected state
    }
    
    
    
    func setupViews() {
        self.selectionStyle = .none
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(posterImageView)
        
        textStack.alignment = .leading
        textStack.axis = .vertical
        textStack.distribution = .equalSpacing
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textStack)
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        textStack.addArrangedSubview(titleLabel)
        
        yearLabel.font = .preferredFont(forTextStyle: .caption1)
        yearLabel.adjustsFontForContentSizeCategory = true
        yearLabel.numberOfLines = 0
        textStack.addArrangedSubview(yearLabel)
        
        imdbIDLabel.font = .preferredFont(forTextStyle: .caption1)
        imdbIDLabel.adjustsFontForContentSizeCategory = true
        imdbIDLabel.numberOfLines = 0
        textStack.addArrangedSubview(imdbIDLabel)
        
        typeLabel.font = .preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.numberOfLines = 0
        textStack.addArrangedSubview(typeLabel)
        
        
        
        contentView.addSubview(stackView)
        
        let heightConstraint = posterImageView.heightAnchor.constraint(equalToConstant: 80)
        heightConstraint.priority = UILayoutPriority(900)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            heightConstraint,
        ])
        
        
    }
    
    public func updateWithOMDBSearchItem(_ item: OMDBSearchItem) {
        titleLabel.text = item.title
        yearLabel.text = item.year
        imdbIDLabel.text = item.imdbID
        typeLabel.text = item.type
        guard let url = item.imageURL else { return }
        
        imageFetchingTask = ImageLoader.loadImage(forURL: url) { [weak self] image in
            self?.posterImageView.image = image
        }
    }
    
    var imageFetchingTask: URLSessionTask? {
        didSet {
            guard imageFetchingTask != oldValue else { return }
            oldValue?.cancel()
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageFetchingTask = nil
    }
}

