//
//  EventTableViewCell.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    // MARK: - Properties
    var event: Event? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    // MARK: - Methods
    func updateViews() {
        guard let event = event else { return }
        eventImageView.load(url: event.image)
        descriptionLabel.text = event.title
        locationLabel.text = "\(event.city), \(event.state)"
        dateLabel.text = "\(event.date)"
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
