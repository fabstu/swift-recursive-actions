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
    
    public func indent(direction: IndentDirection) {
        switch direction {
        case .left:
            // ...
            break
            
        case .right:
            print("Indenting right")
            
            guard let existingParent = self.parent,
                  // FIXME: Simultaneous accesses to 0x101c966f8, but modification requires exclusive access
                  var existingParentChildren = self.parent?.children,
                  // Get index of Item before the Item self.
                  let selfIndexInParent = children.firstIndex(of: self),
                  // Otherwise there is no item infront of self.
                  selfIndexInParent > 0 else {
                return
            }
            
            // Determine new parent as the Item before self.
            let newParent = existingParentChildren[selfIndexInParent - 1]
            
            // Remove self from current parrent.
            existingParentChildren.removeAll(where: { $0 == self})
            
            // Set self's new parent on self.
            self.parent = newParent
            
            // Add self to new parent.
            newParent.children.append(self)
            
            // Assign reference again, probably not necessary.
            existingParent.children = existingParentChildren
        }
    }
}
