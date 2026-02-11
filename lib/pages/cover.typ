#import "../structs.typ": author

#let author-layout(authors: (), max-author-cols: 4, author-cols-width: 80%) = {
    let cols = ()
    let num_cols = 1;
    let fake_entry_pos = 0;
    let number_blank = 0;

    if authors.len() > max-author-cols {
        let num_full_rows = calc.floor(authors.len() / max-author-cols)
        let num_in_last_row = calc.rem(authors.len(), max-author-cols)
        if max-author-cols > 2 and num_in_last_row >= (max-author-cols / 2) {
            number_blank = calc.floor((max-author-cols - num_in_last_row) / 2)
            fake_entry_pos = num_in_last_row * num_in_last_row
        }
        num_cols = max-author-cols
    } else {
        num_cols = authors.len()
    }

    for _ in range(num_cols) {
        cols.push(author-cols-width / num_cols)
    }

    let author-content = ()

    for (i, author) in authors.enumerate() {
        if number_blank > 0 and i == fake_entry_pos {
            for _ in range(number_blank){
                author-content.push([])
            }
        }
        author-content.push([
            #text(author.firstname + " " + author.lastname, size: 14pt, weight: "bold")
            #linebreak()
            #text(str(author.id), size: 12pt)
        ])
    }

    return (cols: cols, author-content: author-content)
}

#let cover-page(
    is-thesis: false,
    is-report: true,
    title: "",
    authors: (author("", "", id: 0, institution: "UoW"),),
    faculty: "",
    study-course: "",
    course: "",
    supervisors: (),
    submission-date: none,
    logo: none,
    max-author-cols: 5,
    author-cols-width: 80%,
    author-bottom-offset: -25%,
    logo-options: (dx: 15mm, dy: 0mm, logo: none),
) = {
    // Set the document's basic properties.
    set page(margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm), numbering: none, number-align: center)

    // Cover Logo
    if logo-options.logo != none {
        place(top + right, dx: logo-options.dx, dy: logo-options.dy, logo-options.logo)
    }

    place(top + center, dy: 30%, align(left, stack(
        // Title
        context {
            show title: set text(size: 31pt, weight: 500)
            std.title()
        },
        v(5mm),
        line(start: (0pt, 0pt), length: 30pt, stroke: 1mm),
        v(5mm),
        text(course, size: 10pt, weight: "bold"),
        v(2mm),
        // Faculty
        text("Faculty of" + " " + faculty, size: 10pt),
        v(45mm),
    )))

    // Author
    let author-display = author-layout(authors: authors, max-author-cols: max-author-cols, author-cols-width: author-cols-width)
    align(center, if authors.len() > 0 {
        place(
            bottom + center,
            dy: author-bottom-offset,
            grid(row-gutter: 5mm, align: center, columns: author-display.cols, ..author-display.author-content),
        )
    })

    // University name text
    place(right + top, dx: 0mm, dy: 95%, box(align(left, stack(
        line(start: (0pt, 0pt), length: 25pt, stroke: 0.9mm),
        v(3mm),
        text("University of Wollongong", size: 9pt, weight: "bold"),
        v(2mm),
        text("Wollongong, NSW", size: 9pt, weight: "bold"),
    ))))

    set text(size: 11pt)
    place(
        left + top,
        dx: 0mm,
        dy: 95%,
        stack(
            // Submission date
            if submission-date != none {
                text("Submitted On: " + submission-date.display("[day padding:zero] [month repr:long] [year repr:full]"))

                v(10pt)
            },
            // Supervision
            if supervisors.len() > 0 and type(supervisors) != array {
                text([Supervising Examiner] + ": " + text(supervisors))
            } else if supervisors.len() > 0 {
                stack(text([Supervising Examiner] + ": " + text(supervisors.first())), if supervisors.len() > 1 {
                    v(10pt)
                    text([Secondary Examiner] + ": " + text(supervisors.at(1)))
                })
            },
        ),
    )
}
