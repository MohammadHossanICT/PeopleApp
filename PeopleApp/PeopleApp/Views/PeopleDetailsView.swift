//
//  PeopleDetailsView.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

struct PeopleDetailsView: View {
    
    @State var people: PeopleData
    var body: some View {
        VStack(alignment: .center) {

            if let url = URL(string: people.avatar ?? "") {
                PeopleAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            Text("First Name - \(people.firstName)")
            Text("Last Name: \(people.lastName ?? " ")")
            Text("Email: \(people.email ?? " ")")

        }
    }
}
struct PeopleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
       PeopleDetailsView(people: Constants.previewPeopleObj)
    }
}
