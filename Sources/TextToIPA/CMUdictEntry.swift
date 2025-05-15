struct CMUdictEntry {
  let name: String
  let phones: [Phone]

  func toIPA() throws -> String {
    return try IPAWord(phones).toString()
  }
}

public struct PhonesWord: Sendable {
  let phones: [Phone]

  func toString() -> String {
    return phones.map { $0.core + ($0.stress ?? "") }.joined(separator: " ")
  }

  func toIPA() throws -> String {
    return try IPAWord(phones).toString()
  }
  func toIPAComponents() throws -> [String] {
    return try IPAWord(phones).getComponents()
  }
}
