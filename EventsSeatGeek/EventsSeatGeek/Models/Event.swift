//
//  Event.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import UIKit

struct Event: Decodable {
    let performers: [Performer]
    let title: String
    let venue: Venue
    let datetime_local: String
    let type: String
}

struct Venue: Decodable {
    var city: String
    var state: String
}

struct Performer: Decodable {
    var image: String
}
