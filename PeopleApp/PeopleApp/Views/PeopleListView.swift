//
//  PeopleListView.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

struct PeopleListView: View {

    @StateObject var viewModel: PeopleListViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.customError != nil && !viewModel.refreshing {
                    alertView()
                } else {
                    if viewModel.refreshing {
                        progressView()
                    }
                    if viewModel.peopleLists.count > 0 && !viewModel.refreshing {

                        List(viewModel.peopleLists, id: \.self) { people in
                            NavigationLink(destination: PeopleDetailsView(people: people)) {

                                PeopleCellView(people: people)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    getToolBarView()
                }
            }
            .navigationTitle(Text("Employees List"))
        }.task{
            await getDataFromAPI()
        }
        .refreshable {
            await getDataFromAPI()
        }
    }

    func getDataFromAPI() async {
        await viewModel.getPeopleList(urlStr: NetworkURL.peopleUrl)
    }

    @ViewBuilder
    func getToolBarView() -> some View {
        Button {
            Task{
                await getDataFromAPI()
            }
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                    .padding(.all, 10.0)
            }.fixedSize()
        }
        .cornerRadius(5.0)
    }

    @ViewBuilder
    func progressView() -> some View {
        VStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(height: 180)
                .overlay{
                    VStack{
                        ProgressView().padding(50)
                        Text("Please Wait Message").font(.headline)
                    }
                }
        }
    }

    @ViewBuilder
    func alertView() -> some View {
        Text("").alert(isPresented: $viewModel.isErrorOccured) {
            Alert(title: Text("General_Error"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(viewModel: PeopleListViewModel(repository: PeopleRepositoryImplementation(networkManager: NetworkManager())))
    }
}

