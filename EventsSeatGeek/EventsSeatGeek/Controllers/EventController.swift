//
//  EventController.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import Foundation

class EventController {
    // MARK: - Properties
    var events: [Event]?
    typealias CompletionHandler = ([Event]?, Error?) -> Void

    // MARK: - REST methods
    func fetchEventsFromServer(completion: @escaping CompletionHandler = { _,_  in }) {
        let requestURL = URL(string: Constants.API_URL)!

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
        var components = URLComponents(string: Constants.API_SEARCH_URL)!
        components.queryItems = [URLQueryItem(name: "q", value: searchText)]

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

                let searchedEvents = eventsArray.events
                completion(searchedEvents, nil)
            } catch {
                NSLog("Error decoding or saving search data: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
}
