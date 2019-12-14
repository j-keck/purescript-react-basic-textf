{ name =
    "react-basic-textf"
, dependencies =
    [ "console"
    , "foreign"
    , "maybe"
    , "psci-support"
    , "quickcheck"
    , "react-basic"
    , "test-unit"
    , "unsafe-coerce"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs", "example/**/*.purs" ]
}
