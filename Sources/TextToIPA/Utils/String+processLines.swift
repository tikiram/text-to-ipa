extension String {
  func processLines(_ action: @escaping (String) throws -> Void) throws {
    var processError: Error?
    self.enumerateLines { line, shouldStop in
      do {
        try action(line)
      } catch {
        shouldStop = true
        processError = error
      }
    }
    if let processError {
      throw processError
    }
  }
}
