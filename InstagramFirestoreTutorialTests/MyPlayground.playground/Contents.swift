// Copyright 2018 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import UIKit

var thumbnailUrl = "http://alpha-k.kakaocdn.net/dna/bgdg10/bIcguzY6JRk/IyNlxVAFpuhXZ65fCLb5tZ/i_ca9836653ee6.jpeg?credential=Ng7s5IScBmZ8GXNU03QieO8KTiRHSUwg&expires=1625546998&signature=YIhj9O%2FRpwV9Kfv49utQPORt97Q%3D&convert=resize&w=74&h=120"

private func makeThumbnailUrl(_ thumbnailUrl: String, constraintSize: CGSize) -> String {
    var seperatedUrl = thumbnailUrl.split(separator: "_")
    let lastElement = seperatedUrl.last?.split(separator: ".")
    seperatedUrl.removeLast()
    
    guard let thumbnailSize = lastElement?.first?.split(separator: "x"), thumbnailSize.count == 2,
        let first = thumbnailSize.first, let width = Int(first),
        let last = thumbnailSize.last, let height = Int(last) else {
            return thumbnailUrl
    }
    var size = CGSize(width: width, height: height)
    let widthRatio = constraintSize.width / size.width
    let heightRatio = constraintSize.height / size.height
    let ratio = min(widthRatio, heightRatio)
    size.width *= ratio
    size.height *= ratio
    
    var newThumbnailUrl = seperatedUrl.joined(separator: "_") + "_\(Int(size.width))x\(Int(size.height))"
    if let last = lastElement?.last, lastElement?.count == 2 {
        newThumbnailUrl += ".\(String(last))"
    }
    return newThumbnailUrl
}

print(makeThumbnailUrl(thumbnailUrl, constraintSize: CGSize(width: 224, height: 448)))
print(makeThumbnailUrl(thumbnailUrl, constraintSize: CGSize(width: 224, height: 448)) == thumbnailUrl)

print(URL(string: "https://alpha-k.kakaocdn.net/dna/5sq7Z/bIcgswoaLo4/rooaSVkk8X0cyVOjX19O9w/i_3f3fa5c791ca.jpeg?credential=Ng7s5IScBmZ8GXNU03QieO8KTiRHSUwg&expires=1625501807&signature=S6R9SUN6cieQXQq7AS%2FdgLP%2B8XI%3D&convert=resize&w=120&h=67"))

let url = URL(string: "https://alpha-k.kakaocdn.net/dna/5sq7Z/bIcgswoaLo4/rooaSVkk8X0cyVOjX19O9w/i_3f3fa5c791ca.jpeg?credential=Ng7s5IScBmZ8GXNU03QieO8KTiRHSUwg&expires=1625501807&signature=S6R9SUN6cieQXQq7AS%2FdgLP%2B8XI%3D&convert=resize&w=120&h=67")

url?.query
url?.query?.contains("credential=")

let naver = URL(string: "https://www.naver.com?test=true")
if let query = naver?.query, !query.isEmpty, !query.contains("credential=") {
    print("HelloWorld")
}
