---
applyTo: "**.typ"
---

# GitHub Copilot Instructions for Academic Notes

## Project Context

This repository contains academic course notes written in Typst, using the [typst-notes-template](https://github.com/Favo02/typst-notes-template).
All custom functions and packages are made available via `#import "template.typ": *` (or a similar relative import) in each file.

## Review Focus Areas

### 1. Typst Syntax

- You are not up to date with the Typst compiler, so if you find anything weird or uncommon, triple check before suggesting an edit
- All external packages (`gentle-clues`, `equate`, `codly`, `fletcher`, `cetz`, `cetz-venn`, `lovelace`, `pinit`) are already available through the template import - do NOT suggest importing them directly in note files
- Do NOT suggest importing NEW Typst external packages beyond those already provided by the template
- It is guaranteed that the code compiles into a valid PDF document

### 2. Template Consistency

- Ensure consistent use of custom info box functions (English names): `note`, `warning`, `informally`, `example`, `proof`, and `theorem`
  - All accept an optional `title:` named argument to override the default title
- Check proper application of the `academic-notes` template function and its parameters
- The template supports bilingual output via `lang: "en"` or `lang: "it"` in `academic-notes`; individual label overrides are available as optional named parameters
- Check proper use of inline math `$...$` and display math `$ ... $`
- Ensure consistent use of colored math helpers: `mg` (green), `mm` (maroon), `mo` (orange), `mr` (red), `mp` (purple), `mb` (blue)
- Also check use of `comment()` for small inline comments inside equations
- Verify proper use of diagram creation tools (`fletcher`, `cetz`, `cetz-venn`) for visual elements
- Check consistent formatting of definition lists using `/` notation (`:` is the separator set by the template)
- Check that incomplete sections are marked with `#todo` (not any other pattern)
- Verify proper use of cross-reference helpers: `link-section()`, `link-theorem()`, `link-equation()`
- Check proper use of `part()` for major document divisions (numbered with Roman numerals)
- Verify pseudocode is written using `pseudocode()` and `indent()` from the `lovelace` package

### 3. Content Clarity

- Language: Check for proper grammar and academic writing style matching the `lang` setting (`"en"` or `"it"`)
- Explanations: Ensure complex concepts are explained clearly and progressively
- Examples: Verify that examples effectively illustrate the concepts
- Mathematical Accuracy: Verify mathematical formulas, algorithms, and proofs for correctness
- Algorithmic Descriptions: Check that algorithm descriptions are clear, complete, and accurate
- Complexity Analysis: Ensure Big O, Omega, and Theta notations are used correctly
- Terminology: Verify proper use of computer science and algorithmic terminology in the document's language

### 4. Diagrams and Drawings

Choose the right abstraction level for each drawing task - neither always high-level nor always low-level:

- Prefer package-level abstractions when they match the concept: use `fletcher` nodes and edges for graphs, automata, and flowcharts; use `cetz-venn` for Venn diagrams. These map naturally to the concept and produce cleaner code.
- Fall back to `cetz` primitives for custom or geometric drawings: lines, rectangles, circles, arcs, and labels via `cetz.draw` are reliable and well-understood - use them for diagrams that don't fit a higher-level abstraction (e.g., geometric proofs, custom data structure illustrations).
- Avoid reinventing what packages already provide: do not draw a graph by manually placing circles and lines with `cetz` if `fletcher` can express the same thing with nodes and edges.
- Avoid over-relying on high-level API details you are uncertain about: `fletcher` and `cetz-venn` have specific APIs that may be mis-recalled - when in doubt, fall back to `cetz` primitives rather than guessing high-level parameters.
- Mixed use is fine: it is acceptable to combine `fletcher` for the graph structure and `cetz` for additional annotations in the same diagram.

### 5. Code Examples and Pseudocode

- Review algorithm implementations for correctness
- Check that code examples follow good programming practices
- Verify syntax highlighting and code formatting using `codly`
- Ensure pseudocode uses `pseudocode()` and `indent()` from `lovelace`, not ad-hoc formatting
- Ensure code examples match the theoretical explanations

## Specific Review Guidelines

### For Pull Requests:

1. Focus on content accuracy over minor formatting issues
2. Prioritize mathematical and algorithmic correctness
3. Suggest improvements for clarity and educational value
4. Check for consistency with existing content style
5. Do not suggest importing new Typst packages or features
6. Pay attention to `#todo` markers indicating incomplete or unverified sections

### Content Review Priorities:

1. **Mathematical Accuracy**: Verify all formulas, proofs, and complexity analysis
2. **Educational Flow**: Ensure concepts build logically and examples support theory
3. **Language Grammar**: Check for proper academic language usage matching the `lang` setting
4. **Template Consistency**: Verify proper use of all custom helper functions and styling
5. **Visual Elements**: Check that diagrams and mathematical formatting enhance understanding

### Common Patterns to Watch:

- Proper use of `$` for inline math and `$ ... $` for display math
- Consistent use of colored math helpers: `mg()`, `mm()`, `mo()`, `mr()`, `mp()`, `mb()`, `comment()`
- Correct application of info boxes: `note()`, `warning()`, `informally()`, `example()`, `proof()`, `theorem()`
- Consistent use of definition lists with `/` separator for terminology sections
- Proper formatting of pseudocode using `lovelace`: `pseudocode()` and `indent()`
- Proper formatting of highlighted code using `codly`
- Appropriate use of diagram tools: `fletcher` for graphs/automata/flowcharts, `cetz-venn` for Venn diagrams, `cetz` primitives for custom geometric drawings - balanced between high-level APIs and low-level directives (see section 4)
- Cross-references using `link-section()`, `link-theorem()`, `link-equation()`
- Use of `#todo` to flag incomplete sections

## Interaction Style

- Suggest improvements for complex errors
- Simply point out minor issues (like typos) without extensive explanations
- Consider the academic context and the document's language requirements
- When reviewing `#todo` sections, provide constructive guidance on completion
- Respect the established template structure and don't suggest major architectural changes
