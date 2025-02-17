public func getAlphabetDictionary() async throws -> [String: [PhonesWord]] {

  // key was changed to UPPERCASE
  let text = """
    A(2) EY1
    B B IY1
    C S IY1
    D D IY1
    E IY1
    F EH1 F
    G JH IY1
    H EY1 CH
    I AY1
    J JH EY1
    K K EY1
    L EH1 L
    M EH1 M
    N EH1 N
    O OW1
    P P IY1
    Q K Y UW1
    R AA1 R
    S EH1 S
    T T IY1
    U Y UW1
    V V IY1
    W D AH1 B AH0 L Y UW0
    X EH1 K S
    Y W AY1
    Z Z IY1
    """

  return try await loadDictionaryText(text)
}
