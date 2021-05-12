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
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import UIKit
import PlaygroundSupport
import Promises

PlaygroundPage.current.needsIndefiniteExecution = true
// https://theswiftdev.com/promises-in-swift-for-beginners/

enum PlaygroundError: Error {
  case invalidNumber
}

func reverse(string: String) -> Promise<String> {
  return Promise(String(string.reversed())).delay(0.1)
}

func reverse2(string: String) -> Promise<String> {
    return Promise { () -> String in
        return String(string.reversed())
    }
}

func string(from number: Int) -> Promise<String> {
  return Promise { () -> String in
    return String(number)
  }.delay(0.1)
}

func number(from string: String) -> Promise<Int> {
  return Promise { () -> Int in
    guard let number = Int(string) else { throw PlaygroundError.invalidNumber }
    return number
  }.delay(0.1)
}

func number2(from string: String) -> Promise<Int> {
  return Promise { fulfill, reject in
    guard let number = Int(string) else { reject(PlaygroundError.invalidNumber); return }
    fulfill(number)
  }.delay(0.1)
}

func square(number: Int) -> Int {
  return number * number
}

func divide(_ number: Int, by: Int) -> Promise<Int> {
    return Promise {
        return number / by
    }
}

func divide2(_ number: Int, by: Int) -> Promise<Int> {
    return Promise(number / by)
}

func divide3(_ number: Int, by: Int) -> Promise<Int> {
    return Promise { () -> Int in
        let newNumber = number + 1
        return newNumber / by
    }
}

func divide4(_ number: Int, by: Int) -> Promise<Int> {
    return Promise { fullfill, reject in
        if number % 2 == 0 {
            fullfill(number / by)
        } else {
            reject(PlaygroundError.invalidNumber)
        }
    }
}

reverse2(string: "4000")
    .then(number(from:))
    .then { number in
        return divide3(number, by: 2)
    }.then(square(number:))
    .then { number in
        return divide2(number, by: 1)
    }
    .then { result in
        print("0", result)
    }
    .catch { error in
        print("0", error)
    }

reverse(string: "5000")
    .then(number(from:))
    .then { number in
        return divide(number, by: 2)
    }.then { result in
        string(from: result)
    }.then { result in
        print(result)
    }
    .catch { error in
        print("1", error)
    }

reverse(string: "01")
    .then(number(from:))
    .then(square(number:))
    .then {
        print("2", $0) // 100
    }

reverse(string: "hello")
    .then(number(from:))
    .catch { error in
        print("3", error)
    }
//
//DispatchQueue.concurrentPerform(iterations: 1) { (i) in
//    print(i)
//}

var a = CGRect(x: 0, y: 0, width: 10, height: 10)
var b = a
b.size = CGSize(width: 20, height: 20)
print(a)
print(b)


protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    typealias Item = Int

    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

let stack1: some Container = IntStack()
let stack2: some Container = Stack<Int>()

print(type(of: stack1))
print(type(of: stack2))
protocol ItemStoring {
    associatedtype DataType

    var items: [DataType] { get set}
    mutating func add(item: DataType)
}

extension ItemStoring {
    mutating func add(item: DataType) {
        items.append(item)
    }
}

struct NameDatabase: ItemStoring {
    typealias DataType = String
    var items = [String]()
}
