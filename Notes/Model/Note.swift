//
//  Note.swift
//  Notes
//
//  Created by Zachary Frew on 7/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class Note: Equatable, Codable {
    
    // MARK: - Properties
    var body: String
    
    // MARK: - Initializers
    init(body: String) {
        self.body = body
    }
    
    // MARK: - Protocol Conformance
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.body == rhs.body
    }
    
}
