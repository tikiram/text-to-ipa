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
    return try isPreviousPhoneConsonant(currentIndex: index) ? 1 : 0
  }

  private func isPreviousPhoneConsonant(currentIndex index: Int) throws -> Bool {
    let previousPhone = index == 0 ? nil : phones[index - 1]
    return try previousPhone?.isConsonant() == true
  }

}
