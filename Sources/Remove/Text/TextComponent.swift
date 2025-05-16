
struct TextComponent {
  let elements: [Element]

  func toString() -> String {
    return elements.map { $0.toString() }.joined()
  }
  
  func transcribe(_ transcriber: IPATranscriber) throws -> [Transcription] {
    return try elements.map{ try $0.transcribe(transcriber) }
  }
}
