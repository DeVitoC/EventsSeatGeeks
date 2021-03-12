//
//  EventController.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import Foundation
import CoreData

class EventController {
    // MARK: - Properties
    var events: [Event]?
    typealias CompletionHandler = ([Event]?, Error?) -> Void

    // MARK: - REST methods
    func fetchEventsFromServer(completion: @escaping CompletionHandler = { _,_  in }) {
        var components = URLComponents(string: Constants.API_URL)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.CLIENT_ID),
            URLQueryItem(name: "client_secret", value: Constants.API_KEY),
            URLQueryItem(name: "per_page", value: "500")
        ]

        let requestURL = URLRequest(url: components.url!)

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching events: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data returned by dataTask")
                completion(nil, NSError())
                return
            }

            do {
                let eventsArray = try JSONDecoder().decode(Events.self, from: data)

                self.events = eventsArray.events
                completion(self.events, nil)
            } catch {
                NSLog("Error decoding or saving data from SeatGeek: \(error)")
                completion(nil, error)
            }

        }.resume()
    }

    func fetchSearchResultsFromServer(searchText: String, completion: @escaping CompletionHandler = { _,_ in }) {
        var components = URLComponents(string: Constants.API_URL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "client_id", value: Constants.CLIENT_ID),
            URLQueryItem(name: "client_secret", value: Constants.API_KEY),
            URLQueryItem(name: "per_page", value: "500")
        ]

        let requestURL = URLRequest(url: components.url!)

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data returned by search dataTask")
                completion(nil, NSError())
                return
            }

            do {
                let eventsArray = try JSONDecoder().decode(Events.self, from: data)

                completion(eventsArray.events, nil)
            } catch {
                NSLog("Error decoding or saving search data: \(error)")
                completion(nil, error)
            }
        }.resume()
    }

    // MARK: - CoreData Methods
    func addFavorite(event: Event, context: NSManagedObjectContext) {
        if let newFavorite = Favorite(event: event, context: context) {
            context.insert(newFavorite)
        }
    }

    func removeFavorite(event: Event) {
        let context = CoreDataStack.shared.mainContext
        if let deletedFavorite = Favorite(event: event, context: context) {
            context.delete(deletedFavorite)
        }
    }

    func fetchFavoritesFromCoreData() -> [Event] {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        var favoriteEvents: [Event] = []

        context.performAndWait {
            do {
                let favorites = try context.fetch(fetchRequest)
                for favorite in favorites {
                    guard let event = favorite.event else { continue }
                    favoriteEvents.append(event)
                }
            } catch {
                NSLog("Error fetching favorites from core data: \(error)")
            }
        }

        return favoriteEvents
    }
}
