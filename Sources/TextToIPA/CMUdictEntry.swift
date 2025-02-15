struct CMUdictEntry {
  let name: String
  let phones: [Phone]

  func toIPA() throws -> String {
    return try IPAText(phones).toString()
  }
}

public struct PhonesWord {
  let phones: [Phone]

  func toIPA() throws -> String {
    return try IPAText(phones).toString()
  }
}
