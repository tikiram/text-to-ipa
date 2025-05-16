struct Element {
  let text: String
  let isWord: Bool

  func toString() -> String {
    return "(\(text)|\(isWord))"
  }

  // TODO: receive previous and next Element
  func transcribe(_ transcriber: IPATranscriber) throws -> Transcription {
    let ipas = try transcriber.getIPAs(word: text)
    return Transcription(text: text, isWord: isWord, ipas: ipas)
  }

}

struct Transcription: Codable {
  let text: String
  let isWord: Bool
  let ipas: [[String]]
}
