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

    // MARK: - IBActions
    @IBAction func
    favoritesBarButtonTapped(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
        // Do any additional setup after loading the view.
    }

    func setupDisplay() {
        guard let event = event else { return }
        eventImageView.load(url: URL(string: event.performers[0].image)!)
        dateLabel.text = "\(event.datetime_local)"
        locationLabel.text = "\(event.venue.city), \(event.venue.state)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
