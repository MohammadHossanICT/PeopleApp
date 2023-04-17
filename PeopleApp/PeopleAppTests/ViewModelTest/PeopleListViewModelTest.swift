//
//  PeopleListViewModelTest.swift
//  PeopleAppTests
//
//  Created by M A Hossan on 17/04/2023.
//

import XCTest
@testable import PeopleApp

final class PeopleListViewModelTest: XCTestCase {

    var fakePeopleRepository: FakePeopleRepository!
    var  peopleListViewModel: PeopleListViewModel!

    @MainActor override func setUp() {
        fakePeopleRepository = FakePeopleRepository()
        peopleListViewModel = PeopleListViewModel(repository: fakePeopleRepository)
    }
    override func tearDown() {
        fakePeopleRepository = nil
        peopleListViewModel = nil
    }

    // when url is correct, should have some data in EmployeeList
    func test_getPeopleList_when_url_is_correct() async {

        await peopleListViewModel.getPeopleList(urlStr: "people")
        let peopleList =  await peopleListViewModel.peopleLists
        XCTAssertEqual(peopleList.count, 86)
        let localError =  await peopleListViewModel.customError
        XCTAssertNil(localError)
    }

    // when url is incorrect , it will return immediatly , No data in employee array.
    func test_getPeopleList_When_URL_isNotGiven() async {

        await peopleListViewModel.getPeopleList(urlStr: "")
        let peopleList = await peopleListViewModel.peopleLists
        XCTAssertEqual(peopleList.count, 0)
        let localError = await peopleListViewModel.customError
        XCTAssertEqual(localError, .invalidURL)
        XCTAssertNotNil(localError)

    }

    func testGetPeopleList_When_APIFailure() async {

        XCTAssertNotNil(peopleListViewModel)
        await peopleListViewModel.getPeopleList(urlStr: "faile")
        let peopleList = await peopleListViewModel.peopleLists
        XCTAssertEqual(peopleList.count, 0)
        let localError = await peopleListViewModel.customError
        XCTAssertNotNil(localError)
        XCTAssertEqual(localError, NetworkError.dataNotFound)

    }

    func testGetPeopleList_When_URL_is_Incorrect() async {

        XCTAssertNotNil(peopleListViewModel)
        await peopleListViewModel.getPeopleList(urlStr: "www.test.com")
        let peopleList = await peopleListViewModel.peopleLists
        XCTAssertEqual(peopleList.count, 0)
        let localError = await peopleListViewModel.customError
        XCTAssertNotNil(localError)
        XCTAssertEqual(localError, NetworkError.dataNotFound)
    }
}

