#import "./pages/cover.typ": cover-page
#import "./pages/outline.typ": *
#import "structs.typ": author

#import "./utility.typ": *

#let default-values = (
    header-options: (
        h1: (above: 25pt, below: 45pt, font-size: 21pt, weight: 600, new-page: true, extra_top_margin: 70pt),
        h2: (above: 30pt, below: 25pt, font-size: 14pt, weight: 500, new-page: false),
        h3: (above: 20pt, below: 15pt, font-size: 11pt, weight: 500, new-page: false),
    ),
    cover-page-options: (max-author-cols: 4, author-cols-width: 80%, author-bottom-offset: -25%),
    logo-options: (dx: 20mm, dy: -20mm, logo: image("assets/uow-logo-primary.png", width: 300pt)),
)

#let assignment(
    title: none,
    course: "",
    authors: (author("", "", id: 0, institution: "UoW"),),
    margin: (left: 30mm, top: 30mm, right: 30mm, bottom: 30mm),
    header-options: default-values.header-options,
    is-thesis: false,
    has-cover-page: true,
    submission-date: none,
    supervisors: (),
    show-outline: false,
    show-outline-figures: false,
    cover-page-options: (:),
    logo-options: (:),
    pre-content: none,
    post-content: none,
    body,
) = {
    // So you can pass in partial settings otherwise default values.
    header-options.h1 = default-values.header-options.h1 + header-options.h1
    header-options.h2 = default-values.header-options.h2 + header-options.h2
    header-options.h3 = default-values.header-options.h3 + header-options.h3
    cover-page-options = default-values.cover-page-options + cover-page-options
    logo-options = default-values.logo-options + logo-options

    let PAGE_MARGIN_TOP = margin.top
    let THESIS_HEADING_EXTRA_TOP_MARGIN = header-options.h1.extra_top_margin

    set document(author: authors.at(0).lastname, title: title)
    set page(
        paper: "a4",
        margin: margin,
        numbering: "I",
        number-align: right,
        binding: left,
        header-ascent: 24pt,
        header: context {
            // Before
            let selector_before = selector(heading.where(level: 1)).before(here())
            let level_before = int(counter(selector_before).display())
            let headings_before = query(selector_before)

            if headings_before.len() == 0 {
                return
            }

            // After
            let selector_after = selector(heading.where(level: 1)).after(here())
            let level_after = level_before + 1
            let headings_after = query(selector_after)

            if headings_after.len() == 0 {
                return
            }

            // Get headings
            let heading_before = headings_before.last()
            let heading_after = headings_after.first()

            // Decide on heading
            let heading = heading_before
            let level = level_before

            if heading_after.location().page() == here().page() {
                if (
                    heading_after.location().position().y == (PAGE_MARGIN_TOP + THESIS_HEADING_EXTRA_TOP_MARGIN) or heading_after.location().position().y == PAGE_MARGIN_TOP
                ) {
                    // Next header is first element of page
                    return
                } else {
                    heading = heading_after
                    level = level_after
                }
            }

            set text(size: 11.5pt)
            grid(rows: 2, gutter: 5pt, grid(columns: (75%, 25%), align: (left, right), if heading.numbering != none {
                emph(str(level) + " " + heading.body)
            } else {
                emph(heading.body)
            }, if authors.len() == 1 {
                let author = authors.at(0)
                author.firstname + " " + author.lastname
            }), line(length: 100%, stroke: 0.7pt))
        },
    )
    set math.equation(numbering: "(1.1)")

    if has-cover-page {
        context {
            set page(numbering: none)
            cover-page(
                title: title,
                authors: authors,
                faculty: "Computer Science",
                submission-date: submission-date,
                course: course,
                supervisors: supervisors,
                logo-options: logo-options,
                ..cover-page-options,
            )
        }
        counter(page).update(1)
    }

    show heading.where(level: 1): set block(above: header-options.h1.above, below: header-options.h1.below)
    show heading.where(level: 1): set text(size: header-options.h1.font-size, weight: header-options.h1.weight)
    show heading.where(level: 1): it => {
        if header-options.h1.new-page {
            pagebreak(weak: true)
        }
        if is-thesis {
            v(THESIS_HEADING_EXTRA_TOP_MARGIN)
            it
        } else {
            it
        }
    }
    show heading.where(level: 2): set block(above: header-options.h2.above, below: header-options.h2.below)
    show heading.where(level: 2): set text(size: header-options.h2.font-size, weight: header-options.h2.weight)
    show heading.where(level: 2): it => {
        if header-options.h2.new-page {
            pagebreak(weak: true)
        }
        it
    }
    show heading.where(level: 3): set block(above: header-options.h3.above, below: header-options.h3.below)
    show heading.where(level: 3): set text(size: header-options.h3.font-size, weight: header-options.h3.weight)
    show heading.where(level: 3): it => {
        if header-options.h3.new-page {
            pagebreak(weak: true)
        }
        it
    }
    show outline.where(target: figure.where(kind: image)): it => {
        show outline.entry: it => {
            show cite: it => {}
            it
        }
        it
    }

    if show-outline {
        set page(numbering: none)
        include "pages/outline.typ"
    }
    counter(page).update(1)

    if show-outline-figures {
        outline(target: figure.where(kind: image), title: [Figures])
    }

    // Include before-content pages
    pre-content

    // Content
    {
        // Reset page numbering and set it to numbers
        set page(numbering: "1")
        set heading(numbering: "1.1.1.1.1.")
        counter(page).update(1)

        set par(justify: true)

        body
        // Include post-content pages
        set heading(numbering: none)
        post-content
    }
}

