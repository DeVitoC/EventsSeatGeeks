//
//  Event.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 2/16/21.
//

import UIKit

struct Event: Decodable {
    let image: String
    let title: String
    let city: String
    let state: String
    let date: Date

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let date = try container.decode(Date.self, forKey: .date)

        let venueContainer = try container.nestedContainer(keyedBy: VenueCodingKeys.self, forKey: .venue)
        let image = try venueContainer.decode(String.self, forKey: .image)
        let city = try venueContainer.decode(String.self, forKey: .city)
        let state = try venueContainer.decode(String.self, forKey: .state)

        let performersContainer = try container.nestedContainer(keyedBy: PerformersCodingKeys.self, forKey: .performers)
        let title = try performersContainer.decode(String.self, forKey: .title)

        self.image = image
        self.title = title
        self.city = city
        self.state = state
        self.date = date
    }

    enum CodingKeys: String, CodingKey {
        case date = "datetime_utc"
        case venue
        case performers
    }

    enum VenueCodingKeys: String, CodingKey {
        case image
        case city
        case state
    }

    enum PerformersCodingKeys: String, CodingKey {
        case title = "name"
    }
}
