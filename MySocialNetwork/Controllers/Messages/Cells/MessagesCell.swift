//
//  MessagesCell.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblTotalMessages: UILabel!
    
    @IBOutlet weak var lblTimeStamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(at indexPath:IndexPath, viewModel:MessagesViewModel)  {
        self.userImageView.image = UIImage(named: viewModel.getUserImage(at: indexPath))
        self.userImageView.contentMode = .scaleAspectFit
        self.lblUserName.text = viewModel.getUserNme(at: indexPath)
        
        self.lblMessage.text = viewModel.getMessage(at: indexPath)
        
        self.lblTimeStamp.text = viewModel.getTimeStamp(at: indexPath)
        
        self.lblTotalMessages.text = "\(viewModel.getTotalMessagesNew(at: indexPath))"
        
        if viewModel.isNewMessage(at: indexPath) {
            self.lblUserName.textColor = UIColor.red
        } else {
            self.lblUserName.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        }
    }
}
