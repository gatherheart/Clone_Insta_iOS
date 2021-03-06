//
//  Constants.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/21.
//

import Firebase

struct FireBaseCollections {
    static let users = Firestore.firestore().collection("users")
    static let followers = Firestore.firestore().collection("follwers")
    static let following = Firestore.firestore().collection("following")
    static let posts = Firestore.firestore().collection("posts")
    static let comments = Firestore.firestore().collection("comments")
    static let likes = Firestore.firestore().collection("likes")
    static let notifications = Firestore.firestore().collection("notifications")
}
