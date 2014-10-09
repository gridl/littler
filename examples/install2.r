#!/usr/bin/env r
#
# a second example to install one or more packages, now with options

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

## configuration for docopt
doc <- "Usage: install.r [-r REPO] [-l LIBLOC] [-h] [-d DEPS] [--error] [PACKAGES ...]

-r --repos REPO     repository to install from [default: http://cran.rstudio.com]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-d --deps DEPS      Install suggested dependencies as well [default: NA]
-e --error          Throw error and halt if package cannot be installed? (usually a warning). [default: FALSE]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

if(opt$deps == "TRUE" || opt$deps == "FALSE")
  opt$deps <- as.logical(opt$deps)
if(opt$deps == "NA")
  opt$deps <- NA

## installation given selected options and arguments

if (opt$error) {
    withCallingHandlers(
        install.packages(pkgs  = opt$PACKAGES,
                         lib   = opt$libloc,
                         repos = opt$repos,
                         dependencies=opt$deps),
        warning = stop)

} else { 
    install.packages(pkgs  = opt$PACKAGES,
                     lib   = opt$libloc,
                     repos = opt$repos,
                     dependencies=opt$deps)
}
