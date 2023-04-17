//
//  PeopleData.swift
//  PeopleApp
//
//  Created by M A Hossan on 17/04/2023.
//

struct PeopleData: Decodable, Hashable {
    var createdAt: String?
    var firstName: String
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobTitle: String?
    var favouriteColor: String?
    var id: String?
}
typealias People = [PeopleData]
