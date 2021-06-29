Versioning
==========

Summary
-------

Given a version number AGE.MAJOR.MINOR.PATCH, increment the:

1. AGE on the birthday of the software,
1. MAJOR version when you make incompatible API changes,
1. MINOR version when you add functionality in a backwards compatible
   manner, and
1. PATCH version when you make backwards compatible bug fixes.


Introduction
------------

This is a modified version of [Semantic Versioning](https://semver.org/) 2.0.0. 
It has the age in years as fourth version number and the additions for 
pre-release and build information are removed.

This text is licensed under CC BY 4.0 by LibraSubtilis.

Versioning Specification
------------------------

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

1. Software using this versioning MUST declare a public API. This API
could be declared in the code itself or exist strictly in documentation.
However it is done, it SHOULD be precise and comprehensive.

1. A normal version number MUST take the form W.X.Y.Z where W, X, Y, and Z are
non-negative integers, and MUST NOT contain leading zeroes. W is the age, X is
the major version, Y is the minor version, and Z is the patch version.
Each element MUST increase numerically.
For instance: 1.1.9.0 -> 1.1.10.0 -> 1.1.11.0.

1. Once a versioned package has been released, the contents of that version
MUST NOT be modified. Any modifications MUST be released as a new version.

1. Age and Major version zero (0.0.y.z) are for initial development. Anything 
MAY change at any time. The public API SHOULD NOT be considered stable.

1. Version 0.1.0.0 defines the public API. The way in which the version number
is incremented after this release is dependent on this public API and how it
changes.

1. Patch version Z (w.x.y.Z | x > 0) MUST be incremented if only backwards
compatible bug fixes are introduced. A bug fix is defined as an internal
change that fixes incorrect behavior.

1. Minor version Y (w.x.Y.z | x > 0) MUST be incremented if new, backwards
compatible functionality is introduced to the public API. It MUST be
incremented if any public API functionality is marked as deprecated. It MAY be
incremented if substantial new functionality or improvements are introduced
within the private code. It MAY include patch level changes. Patch version
MUST be reset to 0 when minor version is incremented.

1. Major version X (w.X.y.z | X > 0) MUST be incremented if any backwards
incompatible changes are introduced to the public API. It MAY also include minor
and patch level changes. Patch and minor version MUST be reset to 0 when major
version is incremented.

1. Age version W (W.x.y.z | x > 0) MUST be incremented on the birthday of the
software. Patch, minor and major version MUST be reset to 0 when the age is 
incremented.

1. Precedence refers to how versions are compared to each other when ordered.

   1. Precedence MUST be calculated by separating the version into age, major,
      minor, and patch in that order.

   1. Precedence is determined by the first difference when comparing each of
      these identifiers from left to right as follows: Age, major, minor, 
      and patch versions are always compared numerically.

      Example: 1.1.0.0 < 1.2.0.0 < 1.2.1.0 < 1.2.1.1 < 2.0.0.0


Backus–Naur Form Grammar for Valid Versions
-------------------------------------------
```
<valid ver> ::= <age> "." <major> "." <minor> "." <patch>

<age> ::= <numeric identifier>

<major> ::= <numeric identifier>

<minor> ::= <numeric identifier>

<patch> ::= <numeric identifier>

<numeric identifier> ::= "0"
                       | <positive digit>
                       | <positive digit> <digits>

<digits> ::= <digit>
           | <digit> <digits>

<digit> ::= "0"
          | <positive digit>

<positive digit> ::= "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

```

