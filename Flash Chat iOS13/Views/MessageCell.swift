//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Guilherme de Assis dos Santos on 17/06/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var personalImage: UIImageView!
    @IBOutlet weak var messageBuble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
