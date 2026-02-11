/// For creating an author dictionary with correct structure.
///
/// - firstname (str): First name
/// - lastname (str): Last name
/// - id (str, int): Student ID
/// - institution (): University or institution only required if not UoW.
/// -> dictionary
#let author(firstname, lastname, id: 0, institution: "UoW") = (firstname: firstname, lastname: lastname, id: id, institution: institution)
