public struct TResult: Sendable, Codable {
  let text: String
  let transcriptions: [[String]]

  enum CodingKeys: String, CodingKey {
    case text = "t"
    case transcriptions = "ts"
  }

  func toString() -> String {
    return text
  }
}

extension TextTree {
  func transcribe(_ dictionary: IPADictionary) throws -> [[[TResult]]] {
    return try self.lines.map { try $0.transcribe(dictionary) }
  }
}

extension TextLine {
  func transcribe(_ dictionary: IPADictionary) throws -> [[TResult]] {
    return try self.islands.map { try $0.transcribe(dictionary) }
  }
}

extension TextIsland {
  func transcribe(_ dictionary: IPADictionary) throws -> [TResult] {
    return try self.elements.map { try $0.transcribe(dictionary) }
  }
}

extension TextElement {

  func transcribe(_ dictionary: IPADictionary) throws -> TResult {
    if self.isWord {
      let transcriptions = dictionary.getTranscriptionTexts(self.text)
      return TResult(text: self.text, transcriptions: transcriptions)
    }
    return TResult(text: self.text, transcriptions: [])
  }

}
