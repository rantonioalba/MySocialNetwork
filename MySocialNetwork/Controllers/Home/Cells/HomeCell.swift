//
//  HomeCell.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import UIKit

class HomeCell: UITableViewCell {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTimeGo: UILabel!
    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var imageViewFavorite: UIImageView!
    @IBOutlet weak var imageViewMessage: UIImageView!
    @IBOutlet weak var lblCost: UILabel!
    
    @IBOutlet weak var stackViewImagePost: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(at indexPath:IndexPath, viewModel:HomeViewModel)  {
        self.userImageView.image = UIImage(named: viewModel.getUserImage(at: indexPath))
        self.userImageView.contentMode = .scaleAspectFit
        self.lblUserName.text = viewModel.getUserNme(at: indexPath)
        self.lblTimeGo.text = viewModel.getTimeAgo(at: indexPath)
        
        if viewModel.getPostal(at: indexPath) == "" {
            self.stackViewImagePost.isHidden = true
        } else {
            self.imageViewPost.image = UIImage(named: viewModel.getPostal(at: indexPath))
            self.stackViewImagePost.isHidden = false
        }
        
        self.lblCost.text = viewModel.getCost(at: indexPath)
    }
    
}
