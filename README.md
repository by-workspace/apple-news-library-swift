# Apple News Server Library - Swift

The Swift server library for the [Apple News API](https://developer.apple.com/documentation/apple_news).

## Table of Contents

1. [Installation](#installation)
2. [Documentation](#documentation)
3. [Usage](#usage)
4. [Support](#support)

## Installation

### Swift Package Manager

Add the Apple News Library as a dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/workspace/apple-news-library-swift.git", .upToNextMajor(from: "1.0.0"))
]
```

Then add the `AppleNewsLibrary` product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "AppleNewsLibrary", package: "apple-news-library-swift")
    ]
)
```

### Xcode

In Xcode, select your project file, then select the project under **PROJECT**, and then the **Package Dependencies** tab. Click the "+" button and enter the repository URL:

```
https://github.com/workspace/apple-news-library-swift
```

## Documentation

[Apple News API Documentation](https://developer.apple.com/documentation/apple_news)

### API Reference

- [Article Management](https://developer.apple.com/documentation/apple_news/article)
- [Channel Management](https://developer.apple.com/documentation/apple_news/channel) 
- [Section Management](https://developer.apple.com/documentation/apple_news/section)
- [Asset Management](https://developer.apple.com/documentation/apple_news/asset)
- [Authentication](https://developer.apple.com/documentation/apple_news/authentication)

## Usage

### Creating an Article

```swift
import AppleNewsLibrary
import Foundation

// Load your Apple News Format JSON document
let articleJSON = """
{
    "version": "1.0",
    "identifier": "unique-article-id",
    "title": "Sample Article",
    "language": "en",
    "layout": {},
    "components": [
        {
            "role": "title",
            "text": "Sample Article Title"
        },
        {
            "role": "body",
            "text": "This is the article content."
        }
    ]
}
""".data(using: .utf8)!

// Create article metadata
let metadata = ArticleMetadata(
    title: "Sample Article",
    excerpt: "A brief description",
    canonicalURL: "https://example.com/article",
    keywords: ["news", "technology"],
    thumbnailURL: nil,
    transparentToolbar: false,
    videoURL: nil,
    datePublished: Date(),
    dateCreated: Date(),
    dateModified: Date(),
    authors: ["John Doe"],
    campaignData: nil
)

// Create the article
let articleCreate = ArticleCreate(
    document: articleJSON,
    metadata: metadata,
    isPreview: false,
    isSponsored: false,
    isHidden: false,
    isCandidateToBeFeatured: true,
    maturityRating: .general,
    accessLevel: .public
)
```

### Updating an Article

```swift
// Update an existing article
let articleUpdate = ArticleUpdate(
    revision: "current-revision-id",
    document: updatedArticleJSON,
    metadata: updatedMetadata,
    isHidden: false
)
```

### Working with Assets

Assets represent files (images, videos, etc.) uploaded to Apple News:

```swift
import AppleNewsLibrary

// Assets are created when you upload files to articles
// The Asset struct represents the response from the API
```

### Campaign Tracking

Add campaign tracking data to your articles:

```swift
let campaignData = CampaignData(
    name: "Summer Campaign",
    source: "email",
    medium: "newsletter"
)

let metadata = ArticleMetadata(
    title: "Article Title",
    excerpt: "Description",
    // ... other properties
    campaignData: campaignData
)
```

### Article Links and Sections

Associate articles with sections:

```swift
let links = ArticleUpdateLinks(
    sectionIDs: ["section-id-1", "section-id-2"]
)

let articleCreate = ArticleCreate(
    document: articleJSON,
    metadata: metadata,
    links: links
)
```

### Maturity Ratings

Specify content maturity ratings:

```swift
// Available maturity ratings:
// - .general
// - .mature  
// - .kids

let articleCreate = ArticleCreate(
    document: articleJSON,
    metadata: metadata,
    maturityRating: .general
)
```

### Access Levels

Control article visibility:

```swift
// Available access levels:
// - .public
// - .protected
// - .private

let articleCreate = ArticleCreate(
    document: articleJSON,
    metadata: metadata,
    accessLevel: .public
)
```

## Best Practices

1. **Secure Your Credentials**: Never commit API keys and secrets to version control. Use environment variables or secure key management systems.

2. **Handle Errors Gracefully**: Always implement proper error handling when making API calls.

3. **Use Appropriate Content Types**: Ensure your Apple News Format documents conform to the [Apple News Format specification](https://developer.apple.com/documentation/apple_news/apple_news_format).

4. **Test with Preview Mode**: Use `isPreview: true` when testing to avoid publishing test content to production channels.

5. **Respect Rate Limits**: Be mindful of API rate limits and implement appropriate backoff strategies.

## Requirements

- Swift 6.0 or later
- iOS 14.0+ / macOS 13.0+

## Support

### Reporting Issues

For bugs, questions, and feature requests, please use [GitHub Issues](https://github.com/workspace/apple-news-library-swift/issues).

When reporting issues, please include:
- A clear and descriptive title
- Detailed steps to reproduce the problem
- Expected behavior vs. actual behavior
- Code samples (without sensitive data)
- Library version and Swift version

### Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the terms in [LICENSE.txt](LICENSE.txt).

## Additional Resources

- [Apple News Format Reference](https://developer.apple.com/documentation/apple_news/apple_news_format)
- [Apple News API Reference](https://developer.apple.com/documentation/apple_news)
- [Apple News Publisher](https://www.icloud.com/newspublisher)
- [News Publisher Help](https://help.apple.com/newspublisher/)

---

Apple and Apple News are trademarks of Apple Inc.
