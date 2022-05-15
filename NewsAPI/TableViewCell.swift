//
//  TableViewCell.swift
//  NewsAPI
//
//  Created by Олег Рубан on 17.04.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func setup() {
        self.addSubview(newsTitleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(newsImageView)
        
        var constraints = [NSLayoutConstraint]()
        
        //newsTitleLabel
        constraints.append(newsTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0))
        constraints.append(newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant:  -4.0))
        constraints.append(newsTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0))
        constraints.append(newsTitleLabel.heightAnchor.constraint(equalToConstant: 60.0))
        
        //subtitleLabel
        constraints.append(subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0))
        constraints.append(subtitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant:  -4.0))
        constraints.append(subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 4.0))
        constraints.append(subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0))
        
        //newsImageView
        constraints.append(newsImageView.leadingAnchor.constraint(equalTo: newsTitleLabel.trailingAnchor, constant: 4.0))
        constraints.append(newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -4.0))
        constraints.append(newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0))
        constraints.append(newsImageView.heightAnchor.constraint(equalToConstant: 140.0))
        constraints.append(newsImageView.widthAnchor.constraint(equalToConstant: 140.0))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func update(viewModel: ViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        if let data = viewModel.data {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    viewModel.data = data
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
