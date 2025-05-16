extension Array {
  func removeDuplicatedUsingKey(_ keyBuilder: (Element) throws -> String) throws -> [Element] {
    let result = try self.reduce(into: [String: Element]()) { partialResult, Element in
      let key = try keyBuilder(Element)
      partialResult[key] = Element
    }
    return Array(result.values)
  }
}
