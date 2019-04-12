//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by ouyou on 2019/04/10.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentCaptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData:PostData){
        self.postImageView.image = postData.image
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        self.likeLabel.text = "\(likeNumber)"
        
        var comments = postData.comments
        if comments == nil {
            self.commentCaptionLabel.text = ""
        }else {
            self.commentCaptionLabel.text = ""
            var str : String = ""
            for aaa in comments {
                for bbb in aaa {
                    str += bbb.key
                    str += ":"
                    str += bbb.value
                    str += "\n"
                }
            }
           self.commentCaptionLabel.text = str
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
