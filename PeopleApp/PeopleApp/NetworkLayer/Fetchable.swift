//
//  Fetchable.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation


protocol Fetchable {
    func get(url: URL) async throws -> Data
}
