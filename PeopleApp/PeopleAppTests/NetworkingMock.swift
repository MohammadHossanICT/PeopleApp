//
//  NetworkingMock.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation
@testable import PeopleApp

class NetworkingMock: Networking {
    static var data: Data?

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let data = NetworkingMock.data else {
            throw NetworkError.dataNotFound
        }
        return (data, URLResponse())
    }
}
