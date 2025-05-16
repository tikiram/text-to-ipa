public struct IPAPhone: Sendable {
  let core: String
  let stress: String?

  func getType() throws -> String {
    guard let type = types[core] else {
      throw RuntimeError("No type for \(core)")
    }
    return type
  }

  func isVowel() throws -> Bool {
    let type = try getType()
    return type == "vowel"
  }

  func isConsonant() throws -> Bool {
    let type = try getType()
    return type != "vowel"
  }

  func isUnstressed() -> Bool {
    return stress == "0"
  }

  func isPrimaryStress() -> Bool {
    return stress == "1"
  }

  func isSecondaryStress() -> Bool {
    return stress == "2"
  }

  func getStressMark() throws -> String? {
    guard let stress else {
      return nil
    }
    guard let stressMark = stressEquivalent[stress] else {
      throw RuntimeError("No stress mark for \(stress)")
    }
    return stressMark
  }

  func getIpa() throws -> String {
    guard let coreIpa = ipaEquivalent[core] else {
      throw RuntimeError("No IPA equivalente for \(core)")
    }

    if try isVowel() && isUnstressed() {
      return unstressedTable[coreIpa] ?? coreIpa
    }

    return coreIpa
  }
}
