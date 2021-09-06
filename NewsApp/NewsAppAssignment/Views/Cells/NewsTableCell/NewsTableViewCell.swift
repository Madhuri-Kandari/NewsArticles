//
//  NewsTableViewCell.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 26/08/21.
//

import UIKit
import WebKit

class NewsTableViewCell: UITableViewCell{

    @IBOutlet weak var descriptionOutlet: UILabel!

    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//MARK:- Displaying the data on to cells in table using cell model
    var cellViewModel:NewsCellViewModel?{
        didSet{
            descriptionOutlet.text = cellViewModel?.descriptionArticle
            if let imageURl = cellViewModel?.image{
                activityIndicator.startAnimating()
                imageOutlet.loadImageAF(url: imageURl)
                imageOutlet.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionOutlet.text = nil
        imageOutlet.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 10))
    }
    
}
