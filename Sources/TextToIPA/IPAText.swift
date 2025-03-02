class IPAWord {
  private let phones: [Phone]
  init(_ phones: [Phone]) {
    self.phones = phones
  }

  func getComponents() throws -> [String] {
    var ipas: [String] = []

    for (index, phone) in phones.enumerated() {
      let stressMark = try phone.getStressMark()
      let wordHasMultipleVowels = !(try onlyOneVowelInWord())
      if let stressMark, !stressMark.isEmpty && wordHasMultipleVowels {
        let offset = try getStressOffset(currentIndex: index)
        ipas.insert(stressMark, at: ipas.count - offset)
      }
      ipas.append(try phone.getIpa())
    }
    return ipas
  }

  func onlyOneVowelInWord() throws -> Bool {
    let vowelCount = try phones.count { try $0.isVowel() }
    return vowelCount == 1
  }

  func toString() throws -> String {
    return try getComponents().joined()
  }

  private func getStressOffset(currentIndex index: Int) throws -> Int {
    let previousPhone = phones[safe: index - 1]
    
    guard let previousPhone else {
      return 0
    }

    if try previousPhone.isVowel() == true {
      return 0
    }

    if previousPhone.core != "R" {
      return 1
    }

    guard let previousPreviousPhone = phones[safe: index - 2] else {
      return 1
    }

    if ["B", "D", "F", "G", "K", "P", "T"].contains(previousPreviousPhone.core) {
      return 2
    }

    return 1
  }

  private func isPreviousPhoneConsonant(currentIndex index: Int) throws -> Bool {
    let previousPhone = index == 0 ? nil : phones[index - 1]
    return try previousPhone?.isConsonant() == true
  }

}

extension Collection {
  // Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}
