public class IPALoader {

  public init() {}

  public func load() async throws -> IPATranscriber {
    let dictionary = try await loadDictionary()

    return IPATranscriber(dictionary: dictionary)
  }
}
