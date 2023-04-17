//
//  PeopleAppApp.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

@main
struct PeopleAppApp: App {
    var body: some Scene {
        WindowGroup {
            PeopleListView(viewModel: PeopleListViewModel(repository: PeopleRepositoryImplementation(networkManager: NetworkManager())))        }
    }
}
