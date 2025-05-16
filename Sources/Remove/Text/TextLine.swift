
public struct TextLine2 {
  let components: [TextComponent]

  func toString() -> String {
    return components.map { $0.toString() }.joined(separator: " ")
  }
  
  func transcribe(_ transcriber: IPATranscriber) throws -> [[Transcription]] {
    return try components.map{ try $0.transcribe(transcriber) }
  }
}
