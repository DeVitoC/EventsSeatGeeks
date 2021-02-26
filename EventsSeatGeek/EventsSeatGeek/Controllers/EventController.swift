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
    typealias CompletionHandler = (Error?) -> Void

    // MARK: - REST methods
    func fetchEventsFromServer(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = URL(string: Constants.API_URL)!
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching events: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                NSLog("No data returned by dataTask")
                completion(NSError())
                return
            }

            do {
                self.events = try JSONDecoder().decode([Event].self, from: data)

            } catch {
                NSLog("Error decoding or saving data from SeatGeek: \(error)")
                completion(error)
            }
        }
    }
}
