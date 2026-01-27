#import "../classes.typ": author

#let cover-page(
    is-thesis: false,
    is-report: true,
    title: "",
    authors: (author(firstname: "", lastname: "", id: 0, institution: "UoW"),),
    faculty: "",
    study-course: "",
    course: "",
    supervisors: (),
    submission-date: none,
    logo: none,
) = {
    // Set the document's basic properties.
    set page(
        margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm),
        numbering: none,
        number-align: center,
    )

    // HAW Logo
    place(
        top + right,
        dx: 15mm,
        // dy: -10mm,
        image("../assets/uow-logo-primary.png", width: 300pt),
    )

    // Title etc.
    show title: set text(size: 31pt, weight: 500)
    pad(
        left: 57mm,
        top: 90mm,
        right: 18mm,
        stack(
            std.title(),
            v(5mm),
            line(start: (0pt, 0pt), length: 30pt, stroke: 1mm),
            v(5mm),
            text(course, size: 10pt, weight: "bold"),
            v(2mm),
            // Faculty
            text("Faculty of" + " " + faculty, size: 10pt),
            v(45mm),
        ),
    )
    let cols = ()
    for _ in authors {
        cols.push(80% / authors.len())
    }


    align(center, if authors.len() > 0 {
        grid(
            align: center,
            columns: cols,

            ..for author in authors {
                (
                    [
                        #text(author.firstname + " " + author.lastname, size: 14pt, weight: "bold")
                        #linebreak()
                        #text(str(author.id), size: 12pt)
                    ],
                )
            }
        )
    })
    // University name text
    place(
        right + top,
        dx: -15mm,
        dy: 255mm,
        box(
            align(
                left,
                stack(
                    line(start: (0pt, 0pt), length: 25pt, stroke: 0.9mm),
                    v(3mm),
                    text("University of Wollongong", size: 9pt, weight: "bold"),
                    v(2mm),
                    text("Wollongong, NSW", size: 9pt, weight: "bold"),
                ),
            ),
        ),
    )

    if (is-report) {
        set text(size: 11pt)
        place(
            left + top,
            dx: 15mm,
            dy: 255mm,
            stack(
                // Submission date
                if submission-date != none {
                    text(
                        "Submitted On: "
                            + submission-date.display("[day padding:zero] [month repr:long] [year repr:full]"),
                    )

                    v(10pt)
                },

                // Supervision
                if supervisors.len() > 0 and type(supervisors) != array {
                    text(
                        [Supervising Examiner] + ": " + text(supervisors),
                    )
                } else if supervisors.len() > 0 {
                    stack(
                        text(
                            [Supervising Examiner] + ": " + text(supervisors.first()),
                        ),
                        if supervisors.len() > 1 {
                            v(10pt)
                            text(
                                [Secondary Examiner] + ": " + text(supervisors.at(1)),
                            )
                        },
                    )
                },
            ),
        )
    }


    if is-thesis {
        // Second cover page
        pagebreak()

        // Set the document's basic properties.
        set page(
            margin: (left: 31.5mm, right: 32mm, top: 55mm, bottom: 67mm),
            numbering: none,
            number-align: center,
        )

        // Title etc.
        stack(
            // Author
            align(
                center,
                text(author, size: 14pt),
            ),
            v(23mm),
            // Title
            align(
                center,
                par(
                    leading: 13pt,
                    text(title, size: 18pt),
                ),
            ),
            v(22mm),
        )

        v(1fr)

        stack(
            // Content
            stack(
                spacing: 3mm,
                if is-bachelor-thesis {
                    text(translations.bachelor-thesis-submitted-for-examination-in-bachelors-degree)
                },
                if is-master-thesis {
                    text(translations.master-thesis-submitted-for-examination-in-masters-degree)
                },
                text(translations.in-the-study-course + " " + text(study-course, style: "italic")),
                text(translations.at-the-faculty-of + " " + faculty),
                text(translations.at-university-of-applied-science-hamburg),
            ),

            v(4mm),
            line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),
            v(4mm),

            // Supervision
            if supervisors.len() > 0 {
                if type(supervisors) != array {
                    text(translations.supervising-examiner + ": " + text(supervisors, weight: "bold"), size: 10pt)
                } else {
                    text(
                        translations.supervising-examiner + ": " + text(supervisors.first(), weight: "bold"),
                        size: 10pt,
                    )

                    if supervisors.len() > 1 {
                        linebreak()
                        text(translations.second-examiner + ": " + text(supervisors.at(1), weight: "bold"), size: 10pt)
                    }
                }
            },

            // Submission date
            if submission-date != none {
                stack(
                    v(4mm),
                    line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),
                    v(4mm),
                    text(
                        translations.submitted-on + ": " + (translations.submission-date-format)(submission-date),
                        size: 10pt,
                    ),
                )
            },
        )
    }
}
