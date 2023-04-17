//
//  PeopleListViewModel.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation
import Combine

protocol PeopleListViewModelAction: ObservableObject {
    func getPeopleList(urlStr: String) async
}

@MainActor
final class PeopleListViewModel {

    @Published private(set) var peopleLists: [PeopleData] = []
    @Published private(set) var customError: NetworkError?
    @Published private(set) var refreshing = true
    @Published var isErrorOccured = false

    private let repository: PeopleRepository
    init(repository: PeopleRepository) {
        self.repository = repository
    }
}
extension PeopleListViewModel: PeopleListViewModelAction {
    func getPeopleList(urlStr: String) async {
        refreshing = true
        guard let url = URL(string: urlStr) else {
                self.customError = NetworkError.invalidURL
            refreshing = false
            isErrorOccured = false
            return
        }
        do {
            let lists = try await repository.getList(for: url)
            let arr = lists
            refreshing = false
            isErrorOccured = false
            peopleLists = arr

        } catch {
            refreshing = false
            isErrorOccured = true
            customError = error as? NetworkError
        }
    }
}

