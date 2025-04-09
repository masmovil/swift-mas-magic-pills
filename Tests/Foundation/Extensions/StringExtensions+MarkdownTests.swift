import MasMagicPills
import XCTest

final class StringExtensionsMarkdownTests: XCTestCase {
    func test_bold() {
        // Given
        let text = "Hello World"

        // When
        let boldText = text.markdownUtils.bold()

        // Then
        XCTAssertEqual(boldText, "**Hello World**")
    }

    func test_italic() {
        // Given
        let text = "Hello World"

        // When
        let italicText = text.markdownUtils.italic()

        // Then
        XCTAssertEqual(italicText, "*Hello World*")
    }

    func test_link() {
        // Given
        let text = "Click here"
        let url = "https://example.com"

        // When
        let linkText = text.markdownUtils.link(url: url)

        // Then
        XCTAssertEqual(linkText, "[Click here](https://example.com)")
    }

    func test_strikethrough() {
        // Given
        let text = "Deprecated feature"

        // When
        let strikethroughText = text.markdownUtils.strikethrough()

        // Then
        XCTAssertEqual(strikethroughText, "~~Deprecated feature~~")
    }

    func test_code() {
        // Given
        let text = "print(\"Hello\")"

        // When
        let codeText = text.markdownUtils.code()

        // Then
        XCTAssertEqual(codeText, "`print(\"Hello\")`")
    }

    func test_code_block() {
        // Given
        let code = "func hello() {\n    print(\"Hello\")\n}"

        // When
        let codeBlockNoLang = code.markdownUtils.codeBlock()
        let codeBlockWithLang = code.markdownUtils.codeBlock(language: "swift")

        // Then
        XCTAssertEqual(codeBlockNoLang, "```\n\(code)\n```")
        XCTAssertEqual(codeBlockWithLang, "```swift\n\(code)\n```")
    }

    func test_quote() {
        // Given
        let text = "Important quote"

        // When
        let quoteText = text.markdownUtils.quote()

        // Then
        XCTAssertEqual(quoteText, "> Important quote")
    }

    func test_heading() {
        // Given
        let text = "Section title"

        // When
        let heading1 = text.markdownUtils.heading(level: 1)
        let heading2 = text.markdownUtils.heading(level: 2)
        let heading6 = text.markdownUtils.heading(level: 6)
        let hInvalid = text.markdownUtils.heading(level: 8)

        // Then
        XCTAssertEqual(heading1, "# Section title")
        XCTAssertEqual(heading2, "## Section title")
        XCTAssertEqual(heading6, "###### Section title")
        XCTAssertEqual(hInvalid, "###### Section title")
    }

    func test_bullet_list() {
        // Given
        let text = "Item 1\nItem 2\nItem 3"

        // When
        let bulletList = text.markdownUtils.bulletList()

        // Then
        XCTAssertEqual(bulletList, "- Item 1\n- Item 2\n- Item 3")
    }

    func test_numbered_list() {
        // Given
        let text = "First item\nSecond item\nThird item"

        // When
        let numberedList = text.markdownUtils.numberedList()

        // Then
        XCTAssertEqual(numberedList, "1. First item\n2. Second item\n3. Third item")
    }

    func test_empty_string() {
        // Given
        let text = ""

        // When & Then
        XCTAssertEqual(text.markdownUtils.bold(), "****")
        XCTAssertEqual(text.markdownUtils.italic(), "**")
        XCTAssertEqual(text.markdownUtils.link(url: "https://example.com"), "[](https://example.com)")
        XCTAssertEqual(text.markdownUtils.strikethrough(), "~~~~")
        XCTAssertEqual(text.markdownUtils.code(), "``")
        XCTAssertEqual(text.markdownUtils.codeBlock(), "```\n\n```")
        XCTAssertEqual(text.markdownUtils.quote(), "> ")
        XCTAssertEqual(text.markdownUtils.heading(level: 1), "# ")
        XCTAssertEqual(text.markdownUtils.bulletList(), "")
        XCTAssertEqual(text.markdownUtils.numberedList(), "")
    }

    func testMultilineText() {
        // Given
        let multiline = "Line 1\nLine 2\nLine 3"

        // When
        let quote = multiline.markdownUtils.quote()

        // Then
        XCTAssertEqual(quote, "> Line 1\nLine 2\nLine 3")
    }

    func testSpecialCharacters() {
        // Given
        let text = "Special characters: !@#$%^&*()"

        // When
        let boldText = text.markdownUtils.bold()
        let italicText = text.markdownUtils.italic()
        let codeText = text.markdownUtils.code()

        // Then
        XCTAssertEqual(boldText, "**Special characters: !@#$%^&*()**")
        XCTAssertEqual(italicText, "*Special characters: !@#$%^&*()*")
        XCTAssertEqual(codeText, "`Special characters: !@#$%^&*()`")
    }
}
