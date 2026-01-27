// Abbreviations
// Use: @key or @key:pl to reference and #print-glossary to print it
// More documentation: https://typst.app/universe/package/glossarium/
// Key 	        Type 	            Required/Optional 	Description
// key 	        string 	            required 	        Case-sensitive, unique identifier used to reference the term.
// short 	    string or content 	semi-optional 	    The short form of the term replacing the term citation.
// long 	    string or content 	semi-optional 	    The long form of the term, displayed in the glossary and on the first citation of the term.
// description 	string or content 	optional 	        The description of the term.
// plural 	    string or content 	optional 	        The pluralized short form of the term.
// longplural 	string or content 	optional 	        The pluralized long form of the term.
// group 	    string 	            optional 	        Case-sensitive group the term belongs to. The terms are displayed by groups in the glossary.
// custom 	    any 	            optional 	        Custom content for usage in “user functions”, e.g. user-print-glossary (see advanced docs)

#let abbreviations-entry-list = (
    // // Use key as short by default
    // (
    //     key: "kuleuven",
    // ),
    // Add SHORT
    // (
    //     key: "kuleuven",
    //     short: "KU Leuven",
    // ),
    // Add LONG
    (
        key: "unamur",
        short: "UNamur",
        long: "Namur University",
    ),
    // Add a DESCRIPTION
    (
        key: "oidc",
        short: "OIDC",
        long: "OpenID Connect",
        description: [
            OpenID is an open standard and decentralized authentication protocol promoted by the non-profit
            #link("https://en.wikipedia.org/wiki/OpenID#OpenID_Foundation")[OpenID Foundation].
        ],
    ),
    // Add a PLURAL form
    (
        key: "potato",
        short: "potato",
        // "plural" will be used when "short" should be pluralized
        plural: "potatoes",
    ),
    // Add a LONGPLURAL form
    (
        key: "dm",
        short: "DM",
        long: "diagonal matrix",
        // "longplural" will be used when "long" should be pluralized
        longplural: "diagonal matrices",
        description: "Probably some math stuff idk.",
    ),
    // Add a GROUP
    (
        key: "kuleuven",
        short: "KU Leuven",
        // The terms are displayed by groups in the glossary
        group: "Universities",
    ),
    (
        key: "uow",
        short: "UoW",
        long: "University of Wollongong",
        // The terms are displayed by groups in the glossary
        group: "Universities",
    ),
    // Add a CUSTOM entry
    (
        key: "c",
        short: $c$,
        description: "Speed of light in vacuum",
        // The custom key will be ignored by the default print-glossary function
        custom: (unit: $op("m s")^(-1)$),
    ),
)
