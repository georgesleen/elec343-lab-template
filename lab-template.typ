#let make-document-title(course, lab_number, authors) = [
  #course: Lab #lab_number — #authors.map(a => a.name).join(", ")
]

#let render-title-page(
  course: "ELEC 343",
  lab_number: 1,
  section_number: "",
  bench_number: none,
  date_performed: datetime.today(),
  date_submitted: datetime.today(),
  authors: (),
) = {
  // Title page layout
  box(width: 100%, height: 100%)[
    align(center + horizon)[
    #title[#course]
    Lab \##lab_number
    #if section_number != "" { [Section: #section_number] }
    #if bench_number != none { [Bench \##bench_number] }
    ]

    table(
    columns: (1fr, 1fr, 1fr, 1fr),
    [Partners], [Student ID \#:], [% Participation], [Signatures],

    ..authors
    .map(a => (
    [#a.name],
    [#a.student_number],
    [#calc.round(a.percent_participation, digits: 1)],
    [#a.name], // or [] for blank signatures
    ))
    .flatten(),
    )

    align(left + bottom)[
    Date Performed: #date_performed.display()
    \
    Date Submitted: #date_submitted.display()
    ]
  ]
}

#let elec343-lab(
  // Metadata
  authors: (),
  lab_number: 1,
  section_number: "",
  bench_number: none,
  date_performed: datetime.today(),
  date_submitted: datetime.today(),

  // Overrides
  paper: "a4",
  font: "New Computer Modern",
  font_size: 10pt,
) = {
  let course = "ELEC 343"
  let doc_title = make-document-title(course, lab_number, authors)

  // Global document settings
  set page(
    paper: paper,
    numbering: "1",
    number-align: right,
  )
  set text(font: font, size: font_size)
  set par(justify: true)
  set heading(numbering: "1.")
  set document(title: doc_title)

  // Title page
  render-title-page(
    course: course,
    lab_number: lab_number,
    section_number: section_number,
    bench_number: bench_number,
    date_performed: date_performed,
    date_submitted: date_submitted,
    authors: authors,
  )
  pagebreak()
}
