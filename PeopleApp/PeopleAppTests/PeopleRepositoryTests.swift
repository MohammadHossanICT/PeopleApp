//
//  PeopleRepositoryTests.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import XCTest
@testable import PeopleApp

final class PeopleRepositoryTests: XCTestCase {

    var fakeNetworkManager: FakeNetworkManager!
    var peopleRepository: PeopleRepository!

    override func setUpWithError() throws {
        fakeNetworkManager = FakeNetworkManager()
        peopleRepository = PeopleRepositoryImplementation (networkManager: fakeNetworkManager)
    }
    override func tearDownWithError() throws {
        peopleRepository = nil
    }

    // when passes employee list array will return with some data
    func test_when_get_People_list_success() async {
        let lists = try? await peopleRepository.getList(for: URL(string:"people")!)
        XCTAssertNotNil(lists)
        XCTAssertEqual(lists?.count,86)
        XCTAssertEqual(lists?.first?.firstName,"Maggie")

    }

    // when fails, employee list will be nil
    func test_when_get_People_list_fails() async throws{
        let lists = try? await peopleRepository.getList(for: URL(string:"faile")!)
        XCTAssertNil(lists)

    }
}

