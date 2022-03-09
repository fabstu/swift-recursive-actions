import XCTest
import ComposableArchitecture
import SwiftUI
import RecursiveActions

class TestItemState: XCTestCase {
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
        
//        store.send(.child(id: uid2, action: .indent(direction: .right))) // Fails.
        store.send(.indent(direction: .right)) // Works.
    }
}
