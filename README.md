# Sending action that is handled recursively crashes app

Error description:

> Simultaneous accesses to 0x11b8b28e8, but modification requires exclusive access.

The error occurs in [Actions.swift](https://github.com/fabstu/swift-recursive-actions/blob/main/Sources/RecursiveActions/Actions.swift#L51).
I assume it is about having a tree data structure with a back-reference on the parent. Accessing attributes of the parent item makes the game crash, but it is unclear why.
