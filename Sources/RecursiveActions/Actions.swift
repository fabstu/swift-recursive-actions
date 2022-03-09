import Combine
import ComposableArchitecture
import SwiftUI
import CasePaths

public indirect enum ItemAction: Equatable {
    case child(id: UUID, action: ItemAction)
    case editText(newText: String)
    case indent(direction: IndentDirection)
}

public struct AppEnvironment {
    public init(mainQueue: AnySchedulerOf<DispatchQueue> = .main) {
        self.mainQueue = mainQueue
    }
    
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

extension Reducer {
    static func recurse(
        _ reducer: @escaping (Reducer, inout State, Action, Environment) -> Effect<Action, Never>
    ) -> Reducer {
        
        var `self`: Reducer!
        self = Reducer { state, action, environment in
            reducer(self, &state, action, environment)
        }
        return self
    }
}

public let nestedReducer = Reducer<
    ItemState, ItemAction, AppEnvironment
>.recurse { reducer, state, action, environment in
    switch action {
    case .child:
        return reducer.forEach(
            state: \ItemState.children,
            action: /ItemAction.child(id:action:),
            environment: { $0 }
        )
        .run(&state, action, environment)
        
    case let .editText(newText):
        state.content = newText
        return .none
        
    case let .indent(direction):
        //FIXME: Crashes on access to .children.
        state.parent?.children
        return .none
    }
}
.debugActions()
