//
//  FakePeopleRepository.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation
@testable import PeopleApp

class FakePeopleRepository: PeopleRepository {
    func getList(for url: URL) async throws -> PeopleApp.People {
        do {
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path =  bundle.url(forResource:url.absoluteString, withExtension: "json") else {
                throw NetworkError.invalidURL
            }
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let lists = try decoder.decode(People.self, from: data )
            return lists
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
