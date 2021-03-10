//
//  Events.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 3/4/21.
//

import Foundation

struct Events: Decodable {
    var events: [Event]

    enum CodingKeys: CodingKey {
        case events
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.events = try container.decode(LossyArray<Event>.self, forKey: .events).elements
    }
}
