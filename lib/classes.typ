/// For creating an author dictionary with correct structure.
///
/// - firstname (str): First name
/// - lastname (str): Last name
/// - id (): Student ID
/// - institution (): University only if not UoW.
/// -> dictionary
#let author(lastname: "", firstname: "", id: 0, institution: "UoW") = (
    firstname: firstname,
    lastname: lastname,
    id: id,
    institution: institution,
)
