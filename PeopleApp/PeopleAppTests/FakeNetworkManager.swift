//
//  FakeNetworkManager.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation
@testable import PeopleApp

class FakeNetworkManager: Fetchable {
    func get(url: URL) async throws -> Data {
        do {
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path =  bundle.url(forResource:url.absoluteString, withExtension: "json") else {
                throw NetworkError.invalidURL
            }
            let data = try Data(contentsOf: path)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}

