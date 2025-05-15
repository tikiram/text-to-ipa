public class IPALoader {

  public func load() async throws -> Transcriber {
    let dictionary = try await loadDictionary()

    return Transcriber(dictionary: dictionary)
  }
}
