//
//  Constants.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import Firebase

enum FireBaseCollections {
    static let users = Firestore.firestore().collection("users")
    static let followers = Firestore.firestore().collection("follwers")
    static let following = Firestore.firestore().collection("following")
}
