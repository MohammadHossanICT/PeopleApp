//
//  NetworkManager.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation

struct NetworkManager {
    private let urlSession: Networking
    init(urlSession: Networking = URLSession.shared) {
        self.urlSession = urlSession
    }
}
extension NetworkManager: Fetchable {
    func get(url: URL) async throws -> Data {
        do {
            let (data, _) = try await urlSession.data(from: url)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}

