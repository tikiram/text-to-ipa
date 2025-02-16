public struct Document {
  let lines: [TextLine]

  func transcribe(_ transcriber: Transcriber) throws -> TranscriptionDocument {
    let transcriptionsMatrix = try lines.map { try $0.transcribe(transcriber) }
    return TranscriptionDocument(transcriptionsMatrix: transcriptionsMatrix)
  }
}

struct TranscriptionDocument: Codable {
  let transcriptionsMatrix: [[[Transcription]]]
  
  func printFullString() {
    for line in transcriptionsMatrix {
      for component in line {
        for element in component {
          
          print("\(element.text): \(element.ipas)")
        }
      }
    }
  }
}
