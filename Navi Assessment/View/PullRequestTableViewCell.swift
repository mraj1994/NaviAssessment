//
//  PullRequestTableViewCell.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import UIKit
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var prTitleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var prStateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitalUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupInitalUI(){
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }
    
    func setupData(data: PullRequestResponseModel){
        if let urlString = data.user?.avatarURL {
            SDWebImageManager.shared.loadImage(with: URL(string: urlString), progress: nil) { image, _, _, _, _, _ in
                self.profileImageView.image = image
            }
        }
        if let title = data.title {
            self.prTitleLabel.text = title
        }
        
       
        
        if let createdAt = data.createdAt {
            //formatting date
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            
            let createdDate: Date? = dateFormatterGet.date(from: createdAt)
            
            var labelText = "Created at: \(dateFormatter.string(from: createdDate!))"
            if let closedAt = data.closedAt {
                let closedDate: Date? = dateFormatterGet.date(from: closedAt)
                labelText.append(contentsOf: "\nClosed at: \(dateFormatter.string(from: closedDate!))")
            }
            self.createdAtLabel.text = labelText
        }
        
        if let userName = data.user?.login {
            self.userNameLabel.text = "User Name: @" + userName
        }
        
        if let state = data.state {
            self.prStateLabel.text =  "  " + state.capitalized + "  "
            let type = PullRequestType.getState(type: state)
            self.prStateLabel.backgroundColor = PRUtils().stateBGColour(forState: type)
            self.prStateLabel.clipsToBounds = true
            self.prStateLabel.layer.cornerRadius = 4
            self.prStateLabel.textColor = .white
        }
        
    }
    
}
