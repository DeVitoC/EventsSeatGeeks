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
}
