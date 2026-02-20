// Academic Notes Template
// A template for university course notes with rich formatting features
// Author: Luca Favini (Favo02)

#import "@preview/gentle-clues:1.2.0"
#import "@preview/equate:0.3.2"
#import "@preview/cetz:0.4.0"
#import "@preview/fletcher:0.5.8"
#import "@preview/cetz-venn:0.1.4"
#import "@preview/lovelace:0.3.0": indent, pseudocode
#import "@preview/codly:1.3.0"
#import "@preview/pinit:0.2.2"

// ============================================================================
// LANGUAGE DEFAULTS
// ============================================================================
// Pass lang: "en" or lang: "it" to academic-notes to select one.
// Any individual field can still be overridden independently.

#let lang-en = (
  last-modified-label: "Last modified",
  outline-title: "Table of Contents",
  part-label: "Part",
  note-title: "Note",
  warning-title: "Warning",
  informally-title: "Informally",
  example-title: "Example",
  proof-title: "Proof",
  theorem-title: "Theorem",
  theorem-label: "THM",
  figure-supplement: "Figure",
  equation-supplement: "EQ",
)

#let lang-it = (
  last-modified-label: "Ultima modifica",
  outline-title: "Indice",
  part-label: "Parte",
  note-title: "Nota",
  warning-title: "Attenzione",
  informally-title: "Informalmente",
  example-title: "Esempio",
  proof-title: "Dimostrazione",
  theorem-title: "Teorema",
  theorem-label: "THM",
  figure-supplement: "Figura",
  equation-supplement: "EQ",
)

// ============================================================================
// COLORED MATH TEXT HELPERS
// ============================================================================
// Helper functions to color mathematical text for emphasis
// Usage: $mg(x^2) + mo(y^2) = mb(z^2)$

#let mg(body) = text(fill: green, $#body$)     // green
#let mm(body) = text(fill: maroon, $#body$)    // maroon
#let mo(body) = text(fill: orange, $#body$)    // orange
#let mr(body) = text(fill: red, $#body$)       // red
#let mp(body) = text(fill: purple, $#body$)    // purple
#let mb(body) = text(fill: blue, $#body$)      // blue

#let comment(body) = text(size: 8pt, "(" + body + ")") // small comment in equations

// ============================================================================
// COLORED INFO BOXES
// ============================================================================
// Helper functions for different types of information boxes.
// Titles default to the active language; pass title: "..." to override per call.

#let _note-title = state("note-title", "Note")
#let _warning-title = state("warning-title", "Warning")
#let _informally-title = state("informally-title", "Informally")
#let _example-title = state("example-title", "Example")
#let _proof-title = state("proof-title", "Proof")
#let _theorem-title = state("theorem-title", "Theorem")
#let _theorem-label = state("theorem-label", "THM")

#let note(title: auto, body) = {
  let t = if title != auto { title } else { context _note-title.get() }
  gentle-clues.info(title: t)[#body]
}
#let warning(title: auto, body) = {
  let t = if title != auto { title } else { context _warning-title.get() }
  gentle-clues.warning(title: t)[#body]
}
#let informally(title: auto, body) = {
  let t = if title != auto { title } else { context _informally-title.get() }
  gentle-clues.idea(title: t, accent-color: green)[#body]
}
#let example(title: auto, body) = {
  let t = if title != auto { title } else { context _example-title.get() }
  gentle-clues.experiment(title: t, accent-color: purple)[#body]
}
#let proof(title: auto, body) = {
  let t = if title != auto { title } else { context _proof-title.get() }
  set math.equation(numbering: "(1.1)", supplement: "EQ")
  gentle-clues.memo(title: t)[#body]
}
#let theorems-counter = counter("theorem")
#let theorem(title: auto, body) = {
  let t = if title != auto { title } else { context _theorem-title.get() }
  set math.equation(numbering: "(1.1)", supplement: "EQ")
  theorems-counter.step()
  gentle-clues.task(
    title: t + "  " + emph("(" + context (_theorem-label.get()) + " " + context (theorems-counter.display()) + ")"),
    accent-color: eastern,
  )[#body]
}

// ============================================================================
// LINKING HELPERS
// ============================================================================
// Helper functions for creating cross-references

// Link to a theorem by label
#let link-theorem(label) = {
  underline(link(label, context (_theorem-label.get())
    + " "
    + context (str(1 + theorems-counter.at(locate(label)).first()))))
}

// Link to a section by label
#let link-section(label) = {
  underline(link(label, context {
    let target = query(label).first()
    let heading-number = counter(heading).at(target.location())
    if target.numbering != none {
      numbering(target.numbering, ..heading-number) + " " + target.body
    } else {
      target.body
    }
  }))
}

// Link to a numbered equation by label
#let link-equation(label) = underline(ref(label))

// ============================================================================
// FRONTMATTER (COVER PAGE AND OUTLINE)
// ============================================================================

#let frontmatter(title, subtitle, authors, introduction, date, last-modified-label, outline-title) = {
  align(center + horizon, block(width: 90%)[
    #text(3em)[*#title*]
    #block(above: 1.5em)[#text(1.3em)[#subtitle]]
    #block(below: 0.8em)[#(
      authors.map(author => [#link("https://github.com/" + author.at(1))[#author.at(0)]]).join([, ])
    )]
    #text(0.8em)[#last-modified-label: #date.display("[day]/[month]/[year]")]
  ])

  pagebreak()

  // Introduction section
  set heading(numbering: none, bookmarked: false, outlined: false)
  [#introduction]

  // Outline styling
  show outline.entry.where(level: 1): it => {
    if it.element.numbering == none and it.element.outlined {
      v(0.5em)
      text(1.1em)[*#it*]
    } else {
      it
    }
  }

  outline(
    title: outline-title,
    indent: auto,
  )
}

// ============================================================================
// PART COUNTER AND FUNCTION
// ============================================================================
// Create major divisions in the document (displayed as full pages)
// Parts are numbered with Roman numerals (I, II, III, ...)

#let _part-label = state("part-label", "Part")
#let part-counter = counter("part")
#let part(title, reset-chapters: false, chapters-numbering: auto) = {
  part-counter.step()
  align(center + horizon)[
    #context {
      let part-num = numbering("I", part-counter.get().first())
      let label = _part-label.get()
      heading(level: 1, numbering: none, outlined: true, bookmarked: true)[
        #label #part-num: #title
      ]
    }
  ]
  show: rest => {
    set heading(numbering: chapters-numbering) if (chapters-numbering != auto)
    rest
  }
  if reset-chapters {
    counter(heading).update(0)
  }
}

// ============================================================================
// WORK IN PROGRESS WARNING
// ============================================================================

#let todo = {
  emoji.warning
  [*TODO: this section is pending confirmation, it may be incorrect or incomplete*]
  emoji.warning
}

// ============================================================================
// MAIN TEMPLATE FUNCTION
// ============================================================================

#let academic-notes(
  // Required parameters
  title: str,
  subtitle: str,
  authors: array,
  lang: str, // "en" or "it"
  // Optional parameters
  repo-url: none,
  course-url: none,
  year: none,
  lecturer: none,
  date: datetime.today(),
  license: "CC-BY-4.0",
  license-url: "https://creativecommons.org/licenses/by/4.0/",
  heading-numbering: "1.1.",
  equation-numbering: none,
  page-numbering: "1",
  // Optional parameters with language default
  introduction: auto,
  last-modified-label: auto,
  outline-title: auto,
  part-label: auto,
  note-title: auto,
  warning-title: auto,
  informally-title: auto,
  example-title: auto,
  proof-title: auto,
  theorem-title: auto,
  theorem-label: auto,
  equation-supplement: auto,
  figure-supplement: auto,
  // Content
  body,
) = {
  // ============================================================================
  // VALIDATION
  // ============================================================================

  assert(title != none, message: "title is required")
  assert(subtitle != none, message: "subtitle is required")
  assert(authors.len() > 0, message: "at least one author is required")
  assert(("it", "en").contains(lang), message: "at least one author is required")

  // ============================================================================
  // RESOLVE LANGUAGE DEFAULTS
  // ============================================================================

  let defaults = if lang == "it" { lang-it } else { lang-en }
  let resolve(value, key) = if value == auto { defaults.at(key) } else { value }

  let final-last-modified-label = resolve(last-modified-label, "last-modified-label")
  let final-outline-title = resolve(outline-title, "outline-title")
  let final-part-label = resolve(part-label, "part-label")
  let final-note-title = resolve(note-title, "note-title")
  let final-warning-title = resolve(warning-title, "warning-title")
  let final-informally-title = resolve(informally-title, "informally-title")
  let final-example-title = resolve(example-title, "example-title")
  let final-proof-title = resolve(proof-title, "proof-title")
  let final-theorem-title = resolve(theorem-title, "theorem-title")
  let final-theorem-label = resolve(theorem-label, "theorem-label")
  let final-figure-supplement = resolve(figure-supplement, "figure-supplement")
  let final-equation-supplement = resolve(equation-supplement, "equation-supplement")

  _part-label.update(final-part-label)
  _note-title.update(final-note-title)
  _warning-title.update(final-warning-title)
  _informally-title.update(final-informally-title)
  _example-title.update(final-example-title)
  _proof-title.update(final-proof-title)
  _theorem-title.update(final-theorem-title)
  _theorem-label.update(final-theorem-label)

  // ============================================================================
  // DOCUMENT METADATA
  // ============================================================================

  set document(
    title: title,
    author: authors.map(author => author.at(0)),
  )

  // ============================================================================
  // DEFAULT INTRODUCTION IF NOT PROVIDED
  // ============================================================================

  let intro-en = [
    #show link: underline
    = #title

    Notes from the #if course-url != none [#link(course-url)[#emph[#title]]] else [#emph[#title]] course#if year != none [ (a.y. #year)]#if lecturer != none [, taught by Prof. #lecturer]#if subtitle != none [, #subtitle].

    Created by #(authors.map(author => [#link("https://github.com/" + author.at(1))[#text(author.at(0))]]).join([, ]))#if repo-url != none [, with contributions from #link(repo-url + "/graphs/contributors")[other contributors]].

    #if repo-url != none [
      These notes are open source: #link(repo-url)[#repo-url.split("://").at(1)] licensed under #link(license-url)[#license].
      Contributions and corrections are welcome via Issues or Pull Requests.
    ]

    #final-last-modified-label: #date.display("[day]/[month]/[year]").
  ]

  let intro-it = [
    #show link: underline
    = #title

    Appunti del corso di #if course-url != none [#link(course-url)[#emph[#title]]] else [#emph[#title]]#if year != none [ (a.a. #year)]#if lecturer != none [, tenuto dal Prof. #lecturer]#if subtitle != none [, #subtitle].

    Realizzati da #(authors.map(author => [#link("https://github.com/" + author.at(1))[#text(author.at(0))]]).join([, ]))#if repo-url != none [, con il contributo di #link(repo-url + "/graphs/contributors")[altri collaboratori]].

    #if repo-url != none [
      Questi appunti sono open source: #link(repo-url)[#repo-url.split("://").at(1)] con licenza #link(license-url)[#license].
      Le contribuzioni e correzioni sono ben accette attraverso Issues o Pull Requests.
    ]

    #final-last-modified-label: #date.display("[day]/[month]/[year]").
  ]

  let default-introduction = if lang == "it" { intro-it } else { intro-en }
  let final-introduction = if introduction == auto { default-introduction } else { introduction }

  // ============================================================================
  // FRONTMATTER
  // ============================================================================

  frontmatter(title, subtitle, authors, final-introduction, date, final-last-modified-label, final-outline-title)

  // ============================================================================
  // GENERAL SETTINGS
  // ============================================================================

  set terms(separator: [: ])
  set heading(numbering: heading-numbering)
  set math.equation(numbering: equation-numbering, supplement: final-equation-supplement)
  show: equate.equate.with(breakable: true, sub-numbering: true)
  show: gentle-clues.gentle-clues.with(breakable: true)
  show: codly.codly-init.with()
  show link: underline
  set figure(supplement: final-figure-supplement)

  // ============================================================================
  // PAGE BREAK EVERY CHAPTER
  // ============================================================================

  show heading.where(level: 1): it => {
    pagebreak()
    it
  }

  // ============================================================================
  // HEADER AND FOOTER
  // ============================================================================

  set page(
    numbering: page-numbering,
    number-align: bottom + right,
    header: [
      #set text(8pt, style: "italic")
      #title
      #h(1fr)
      #context [
        #let headings = query(heading)
        #let current-page = here().page()
        #let filtered-headings = headings.filter(h => h.location().page() <= current-page)
        #if filtered-headings.len() > 0 [
          #let current-heading = filtered-headings.last()
          #if current-heading.numbering != none [
            #numbering(
              current-heading.numbering,
              ..counter(heading).at(current-heading.location()),
            ) #current-heading.body
          ] else [
            #current-heading.body
          ]
        ]
      ]
    ],
    footer: [
      #set text(8pt)
      _#authors.map(author => author.at(0)).join(", ") - #date.display("[day]/[month]/[year]")_
      #h(1fr)
      #context [#text(12pt)[#counter(page).display(page-numbering)]]
    ],
  )

  // ============================================================================
  // BODY CONTENT
  // ============================================================================

  body
}
