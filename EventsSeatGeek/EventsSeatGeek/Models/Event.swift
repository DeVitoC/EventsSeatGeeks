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
}
