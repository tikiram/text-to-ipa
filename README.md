
# text-to-ipa

## Add the dependency

```swift
dependencies: [
    .package(url: "https://github.com/tikiram/text-to-ipa.git", from: "0.10.0")
]
```

```swift
  .product(name: "TextToIPA", package: "text-to-ipa")
```

## Transcribe

```swift  
  let text = "Hello world!"
  
  let transcriber = try await loadTranscriber()
  let results = try transcriber.parse(text)

  print(results)
```

##

> `/` are used for phonemic transcription, while symbols enclosed in square brackets `[ ]` are used for phonetic transcription


## TODOs

- Use the cmudict repo as a submodule might be a good idea

> https://github.com/cmusphinx/cmudict
