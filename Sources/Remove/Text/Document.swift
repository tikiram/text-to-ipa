public struct Document {
  let lines: [TextLine2]

  public func transcribe(_ transcriber: IPATranscriber) async throws -> TranscriptionDocument {
    let transcriptionsMatrix = try lines.map { try $0.transcribe(transcriber) }
    return TranscriptionDocument(transcriptionsMatrix: transcriptionsMatrix)
  }
}

public struct TranscriptionDocument: Codable {
  let transcriptionsMatrix: [[[Transcription]]]
  
  public func printFullString() {
    for line in transcriptionsMatrix {
      for component in line {
        for element in component {
          print("\(element.text)")
          for ipa in element.ipas {
            print("\t\t\(ipa.joined(separator: ""))")
          }
        }
      }
    }
  }
}
