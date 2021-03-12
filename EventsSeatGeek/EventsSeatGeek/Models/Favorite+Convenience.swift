//
//  Favorite+Convenience.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 3/12/21.
//

import Foundation
import CoreData

extension Favorite {
    var event: Event? {
        guard let image = image, let city = city, let state = state, let title = title, let date = date, let type = type else { return nil}
        let performer = Performer(image: image)
        let venue = Venue(city: city, state: state)
        return Event(performers: [performer], title: title, venue: venue, datetime_local: date, type: type)
    }

    @discardableResult convenience init(city: String,
                                        state: String,
                                        date: String,
                                        image: String,
                                        title: String,
                                        type: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.city = city
        self.state = state
        self.date = date
        self.image = image
        self.title = title
        self.type = type
    }

    @discardableResult convenience init?(event: Event,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(city: event.venue.city, state: event.venue.state, date: event.datetime_local, image: event.performers[0].image, title: event.title, type: event.type, context: context)
    }
}
