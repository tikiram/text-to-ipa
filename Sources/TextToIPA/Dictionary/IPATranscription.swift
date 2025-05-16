public struct IPATranscription: Sendable {
  let phones: [IPAPhone]

  // func toString() -> String {
  //   return phones.map { $0.core + ($0.stress ?? "") }.joined(separator: " ")
  // }

  // func toIPA() throws -> String {
  //   return try IPAWord(phones).toString()
  // }
  // func toIPAComponents() throws -> [String] {
  //   return try IPAWord(phones).getComponents()
  // }
}
