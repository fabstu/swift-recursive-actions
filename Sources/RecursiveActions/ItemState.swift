import Combine
import ComposableArchitecture
import SwiftUI

public enum IndentDirection: Equatable {
    case left
    case right
}

public final class ItemState: Identifiable, Equatable {
    public let id: UUID
    public var parent: ItemState?
    public var children: IdentifiedArrayOf<ItemState> = []
    public var content: String
    
    public init(
        id: UUID = UUID(),
        parent: ItemState? = nil,
        children: IdentifiedArrayOf<ItemState> = [],
        content: String
    ) {
        self.id = id
        self.parent = parent
        self.children = children
        self.content = content
        
        // Set parent hierarchy correctly to make manual initialization less clunky.
        for child in children {
            child.parent = self
        }
    }
    
    public static func == (lhs: ItemState, rhs: ItemState) -> Bool {
        return lhs.id == rhs.id &&
            lhs.children == rhs.children &&
            lhs.content == rhs.content
    }
}
