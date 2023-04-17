//
//  NetworkManagerTests.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import XCTest
@testable import PeopleApp

final class NetworkManagerTests: XCTestCase {
    /**
     when api is successfull
     get function will return expected data , reading data from locally saved json.
     */
    func test_get_People_list_when_api_is_success() async {
        // Reading local json file data
        let bundle = Bundle(for: NetworkManagerTests.self)
        guard let path =  bundle.url(forResource: "people", withExtension: "json") else { return }
        let data = try? Data(contentsOf: path)
        NetworkingMock.data = data

        let networkManager = NetworkManager(urlSession: NetworkingMock())
        let url = URL(string:"https://www.test.com")!
        let actualData = try! await networkManager.get(url: url)
        XCTAssertEqual(actualData, data)
    }
    /**
     when api is successfull but json parsin fails
     Fetch function will return jsonParsingFailed exception
     */
    func test_get_People_list_failes() async {
        let networkManager = NetworkManager(urlSession: NetworkingMock())
        let url = URL(string:"https://www.test.com")!

        do {
            let _ = try await networkManager.get(url: url)
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.dataNotFound)
        }
    }
}
