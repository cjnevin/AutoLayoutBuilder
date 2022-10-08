#if canImport(UIKit)

import UIKit

@resultBuilder
public enum AutoLayoutBuilder {
    /// Required by every result builder to build combined results from statement blocks.
    public static func buildBlock(_ components: Constrainable...) -> [NSLayoutConstraint] {
        components.flatMap(\.constraints)
    }

    /// Provides support for `for..in` loops.
    public static func buildArray(_ components: [[Constrainable]]) -> [NSLayoutConstraint] {
        components.flatMap { $0.flatMap(\.constraints) }
    }

    /// Provides support for `if` statements that do not have an `else`.
    public static func buildOptional(_ components: [Constrainable]?) -> [NSLayoutConstraint] {
        components?.flatMap(\.constraints) ?? []
    }

    /// Provides support for `if` statements in multi-statement closures, producing conditional content for the `then` branch.
    public static func buildEither(first components: [Constrainable]) -> [NSLayoutConstraint] {
        components.flatMap(\.constraints)
    }

    /// Provides support for `if-else` statements in multi-statement closures, producing conditional content for the `else` branch.
    public static func buildEither(second components: [Constrainable]) -> [NSLayoutConstraint] {
        components.flatMap(\.constraints)
    }

    /// Provides support for `if` statements with `#available()` clauses in multi-statement closures, producing conditional content for the `then` branch, i.e. the conditionally-available branch.
    public static func buildLimitedAvailability(_ components: [Constrainable]) -> [NSLayoutConstraint] {
        components.flatMap(\.constraints)
    }
}

#endif
