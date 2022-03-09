//
//  TestItemViewModel.swift
//
//
//  Created by Fabian Sturm on 09.03.22.
//

import XCTest
import ComposableArchitecture
import SwiftUI
import RecursiveActions

class TestItemState: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testActionsIndent() throws {
        let parentUID = UUID()
        let uid1 = UUID()
        let uid2 = UUID()
        let text1 = "Hello"
        let text2 = "World"
        
        let store = TestStore(
            initialState: ItemState(id: parentUID, children: [
                .init(id: uid1, children: [], content: text1),
                .init(id: uid2, children: [], content: text2),
            ], content: ""),
            reducer: nestedReducer,
            environment: AppEnvironment()
        )
        
        store.send(.child(id: uid2, action: .indent(direction: .right)))
//        store.send(AppAction.item(id: parentUID, action: .indent(direction: .right)))
    }
}
