public func loadTranscriber() async throws -> IPATranscriber {
  let dictionary = try await loadIPADictionary()

  return IPATranscriber(dictionary)
}

public struct IPATranscriber: Sendable {
  private let dictionary: IPADictionary

  init(_ dictionary: IPADictionary) {
    self.dictionary = dictionary
  }

  public func parse(_ text: String) throws -> [[[TResult]]] {
    let textTree = text.toEnglishTextTree()
    return try textTree.transcribe(dictionary)
  }
}
