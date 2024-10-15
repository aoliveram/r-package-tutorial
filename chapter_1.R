library(devtools)

#packageVersion("devtools") #same of the book
#getwd()
#file.path('chapter_1.R')

usethis::create_package("~/anibal/r package tutorial/regexcite")

use_git() # NO WORKING # worked with Tools -> Version Control -> Project Setup

#--- defining function

(x <- "alfa,bravo,charlie,delta")
strsplit(x, split = ",")
str(strsplit(x, split = ","))
strsplit(x, split = ",")[[1]]

strsplit2 <- function(x, split) {
  strsplit(x, split = split)[[1]]
}

use_r("strsplit2") # creates a /R. file in which we have to add the definition

#--- to test using devtools

load_all() # Ctrl+Shift+L

(x <- "alfa,bravo,charlie,delta")
strsplit2(x, split = ",")

exists("strsplit1", where = globalenv(), inherits = FALSE) # strsplit2 is not in evironment

check() # gold standard for check full working order. Ctrl+Shift+E

#--- edit description

# now i have to dd my own metada to DESCRIPTION, like orcid, etc. - Ctrl+. -
# to add a LICENCE, i have to run use_mit_license() -or others- in the console

use_mit_license()

# to add the specilly formatted comment right above strsplit2(), put the cursor
# somewhere in the strsplit1() function definition do Code > Insert roxygen skeleton.
# To trigger the conversion into a man/ Rd. roxygen document, we have to run

document() # roxygen comment into man/strsplit2.Rd - Ctrl+Shift+D -
?strsplit2

check() # checking once more

install() #let's install 'regexcite' in my library - Ctrl+Shift+B -

#--- Clean, restar R session, call the new library

library(regexcite) # without enter to the proyect, also works

x <- "alfa,bravo,charlie,delta"
strsplit1(x, split = ",")

#--- Formalize the tests

library(devtools)
use_testthat() #open the project first. This test the whole package functions, but doesn't generate a folder.

use_test("strsplit2") #open and/or creates a test file. We have to write a example
# in a specific format

test() # - Ctrl+Shift+T -

#--- Using functions from another packages (We stop using strsplit2 from now)

use_package("stringr") # this is a common package to work with strings.
# this add 'stringr' to 'Imports' field in DESCRIPTION

rename_files("strsplit1", "str_split_one") # NO WORKING, renaming to testthat/test-str_split_one.R and R/str_split_one.R manually

document() # to convert our new roxygen comments into proper R documentation,
# and modify NAMESPACE
load_all() # to test the new str_split_one() function

str_split_one("a, b, c", pattern = ", ")

#--- Making the README

# HERE START THE HAPPY GIT STUFF ---

library(usethis)
use_git_config(user.name = "aoliveram", user.email = "anibal.olivera.m@gmail.com")

usethis::create_github_token()
gitcreds::gitcreds_set() # paste token ... Done. I should me able to work with GitHub.

# this was a weird way to connect 'myrepo' in my github with this rstudio.
# the hardest part was ch. 9-11 of Happy Git.
# Maybe CH. 12 is easiest..

# Now i'm in the ch. 17 - Existing project, GitHub first.

gitcreds::gitcreds_set() # paste token ... Done. I should me able to work with GitHub.

usethis::create_from_github(
  "git@github.com:aoliveram/r-package-tutorial.git",
  destdir = "~/anibal/r package tutorial"
) # THIS DON'T WORK.. I'LL TRY WITH RSTUDIO IDE


# END, FINALLY ---

use_readme_rmd() # NO WORKING (maybe because there is no github associated ?)

check()

## Verify Setup

devtools::dev_sitrep()
