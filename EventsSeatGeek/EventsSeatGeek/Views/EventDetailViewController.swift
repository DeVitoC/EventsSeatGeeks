//
//  EventDetailViewController.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 3/4/21.
//

import UIKit

class EventDetailViewController: UIViewController {

    // MARK: - Properties
    var event: Event?

    // MARK: - Outlets
    @IBOutlet weak var favoritesBarButton: UIBarButtonItem!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - IBActions
    @IBAction func
    favoritesBarButtonTapped(_ sender: Any) {
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
    }

    func setupDisplay() {
        guard let event = event else { return }
        titleLabel.text = event.title
        eventImageView.load(url: URL(string: event.performers[0].image)!)
        dateLabel.text = "\(event.datetime_local)"
        locationLabel.text = "\(event.venue.city), \(event.venue.state)"
    }
}
