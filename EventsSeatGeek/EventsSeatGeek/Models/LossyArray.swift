//
//  LossyArray.swift
//  EventsSeatGeek
//
//  Created by Christopher Devito on 3/10/21.
//

import Foundation

struct LossyArray<Element: Decodable>: Decodable {
    private(set) var elements: [Element]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements = [Element]()

        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            do {
                let element = try container.decode(Element.self)
                elements.append(element)
            }
            catch {
                _ = try? container.decode(DiscardedElement.self)
                continue
            }
        }

        self.elements = elements
    }
}

struct DiscardedElement: Codable {}
