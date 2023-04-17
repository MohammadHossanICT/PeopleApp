//
//  PeopleCellView.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//


import SwiftUI

struct PeopleCellView: View {
    let people: PeopleData
    var body: some View {
        HStack {
            if let url = URL(string: people.avatar ?? ""){
                PeopleAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            VStack(alignment: .leading,spacing: 5){
                Text("First Name: " +  people.firstName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)

                Text("Last Name: " + (people.lastName ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text("Email: " + (people.email ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)

            }
        }
    }
}
struct PeopleCellView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleCellView(people: Constants.previewPeopleObj)
    }
}
