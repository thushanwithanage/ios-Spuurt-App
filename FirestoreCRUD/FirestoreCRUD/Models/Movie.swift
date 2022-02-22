//
//  Movie.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/17/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Movie : Identifiable, Codable
{
    @DocumentID var id: String?
    var title: String
    var description: String
    var year: String
    var image: String

    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case description
        case year
        case image
    }
}
