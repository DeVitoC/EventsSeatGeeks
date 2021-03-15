//
//  EventsViewController.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import UIKit
import CoreData

class EventsViewController: UIViewController {

    // MARK: - Properties
    var eventController = EventController()
    var currentListOfEvents: [Event]?
    var favoriteEvents: [Event]?
    var isSearching: Bool = false

    // MARK: - Outlets
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - View Meethods
    override func viewDidLoad() {
        super.viewDidLoad()

        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        searchBar.delegate = self

        favoriteEvents = eventController.fetchFavoritesFromCoreData()
        var favoriteTitles: [String] = []
        
        }

        eventController.fetchEventsFromServer { (events, error) in
            DispatchQueue.main.async {
                if favoriteEvents?.count == 0 {
                    self.currentListOfEvents = events
                } else {

                }
                self.eventsTableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let eventDetailVC = segue.destination as! EventDetailViewController
            guard let indexPath = eventsTableView.indexPathForSelectedRow?.row else {
                return
            }
            eventDetailVC.event = currentListOfEvents?[indexPath]
        }
    }
}

extension EventsViewController: UITableViewDelegate {

}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentListOfEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        cell.event = currentListOfEvents?[indexPath.row]

        return cell
    }

}

extension EventsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            currentListOfEvents = eventController.events
            eventsTableView.reloadData()
            return
        }

        eventController.fetchSearchResultsFromServer(searchText: searchText) { (events, error) in
            DispatchQueue.main.async {
                guard let events = events else { return }

                self.currentListOfEvents = events

                if self.currentListOfEvents?.count == 0 {
                    self.isSearching = false
                } else {
                    self.isSearching = true
                }

                self.eventsTableView.reloadData()
            }
        }
    }
}
