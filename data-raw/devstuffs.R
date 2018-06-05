colin::fill_desc("craneur", "Simple Creation of R Archive Network",
                 "Simple Creation of an R Archive Network, to be hosted on your personnal server.", "craneur")
colin::init_docs()
usethis::use_code_of_conduct()

colin::new_r_file("R6")

usethis::use_package("R6")
usethis::use_package("attempt")
usethis::use_package("desc")
usethis::use_package("tools")
usethis::use_package("glue")

usethis::use_tidy_description()
usethis::use_lifecycle_badge("experimental")
