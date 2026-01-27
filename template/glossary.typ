// Glossary
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


#let glossary-entry-list = (
    (
        key: "freedom",
        short: "freedom",
        description: "Freedom is the power or right to speak, act and change as one wants without hindrance or restraint. Freedom is often associated with liberty and autonomy in the sense of \"giving oneself one's own laws\"",
    ),
)
