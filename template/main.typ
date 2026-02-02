#import "@local/uow:0.1.0": *
#import "dependencies.typ": *

// Any figure show rules need to be above this.
#show: make-glossary
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(abbreviations-entry-list)
#import "glossary.typ": glossary-entry-list
#register-glossary(glossary-entry-list)

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#let authors = (
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
    author(firstname: "Zack", lastname: "Hankin", id: 19201298),
)

#show: assignment.with(
    authors: authors,
    title: "Topic of the Century",
    has-cover-page: true,
    course: "CSCI927 Modern Cryptography",
    supervisors: ("Prof. Rosa Hankin", "Dr. Jack Smith"),
    is-thesis: true,
    submission-date: datetime.today(),
    margin: (left: 20mm, top: 25mm, right: 20mm, bottom: 25mm),
    header-options: (
        h1: (above: 30pt, below: 25pt, font-size: 21pt, weight: 600, new-page: true),
        h2: (above: 35pt, below: 25pt, font-size: 14pt, weight: 500, new-page: false),
        h3: (above: 20pt, below: 15pt, font-size: 11pt, weight: 500, new-page: false),
    ),
    show-outline: true,
    show-outline-figures: true,
    pre-content: {
        include "./abstract.typ"
        heading("Abbreviations")
        print-glossary(abbreviations-entry-list)
    },
    post-content: {
        heading("Glossary")
        print-glossary(glossary-entry-list)
        bibliography(("bibliography/bib.bib", "bibliography/bib.yaml"), style: "harvard-cite-them-right")
    },
)

#include "chapters/1-introduction.typ"
#include "chapters/2-math.typ"
#include "chapters/3-figures.typ"

