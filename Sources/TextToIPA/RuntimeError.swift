
import Foundation

// TODO: we can use vapor-utils
public struct RuntimeError: LocalizedError {
  let description: String

  public init(_ description: String) {
    self.description = description
  }

  public var errorDescription: String? {
    description
  }
}
