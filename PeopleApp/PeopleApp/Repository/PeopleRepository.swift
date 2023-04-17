//
//  PeopleRepository.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation

protocol PeopleRepository {
    func getList(for url: URL) async throws -> People
}

struct PeopleRepositoryImplementation {
    private let networkManager: Fetchable

    init(networkManager: Fetchable) {
        self.networkManager = networkManager
    }
}

extension PeopleRepositoryImplementation: PeopleRepository, JsonParser {
    func getList(for url: URL) async throws -> People {
        do {
            let listsData = try await networkManager.get(url: url)
            return try parse(data: listsData, type: People.self)
        } catch {
            throw error
        }
    }
}
