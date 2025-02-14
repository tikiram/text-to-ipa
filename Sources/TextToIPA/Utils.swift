
import Foundation

func listResources() throws {
  guard let bundleURL = Bundle.module.resourceURL else {
    print("bundle not found")
    return
  }

  let files = try FileManager.default.contentsOfDirectory(
    at: bundleURL, includingPropertiesForKeys: nil)
  print("files")
  files.forEach { print($0.lastPathComponent) }
}
