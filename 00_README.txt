This file describes how to get started and some important preliminary knowledge.

This project (in the RStudio sense of the word) MUST be openined by double
clicking the file 01_NLM_lecture_notes.Rproj

Numbers for some of the important files, so that you will find them near the
top in your list of files. That is also why this file is calles 00_README.txt

IMPORTANT THINGS YOU NEED TO KNOW

1. Always open this project in Rstudio by clicking 01_NLM_lecture_notes.Rproj
  - See here for information about projects:
      https://r4ds.hadley.nz/workflow-scripts.html#projects
2. This project uses renv to have the same versions of packages for everyone
   who contributes to the lecture notes (so, if it works for one, it works for
   all).
  - Rstudio should automatically download and install renv and ask you to
    download and install the required packages (say YES to this!)
  - See here for information about renv:
    https://rstudio.github.io/renv/articles/renv.html
  - The most IMPORTANT thing you need to know is that if you need a new package
    you should call renv::snapshot() and commit your changes to git and push
    to GitHub (see below). OR: let Dan know which package and version you need
    to add and he can do it.
3. This project uses git and GitHub for version control
  - See here for information about git and GitHub:
    https://happygitwithr.com/
4. Try to follow all the advice in the Best Practise for R :: Cheat Sheet
  - Here: https://github.com/wurli/r-best-practice
  - This includes adhering to the tidyverse style guide for R code
  - Here: https://style.tidyverse.org/

HOW TO CONTRIBUTE TO THE LECTURE NOTES
0. Remember to open the project by double clicking the file
   01_NLM_lecture_notes.Rproj
1. Before you start working on a file, make sure you have the latest version
   from GitHub. You can do this by clicking "pull" on the Git tab.
2. Open and edit the file or files that you want to change.
   For a brief introduction to Quarto, see here: https://r4ds.hadley.nz/quarto
   For more information, see here: https://quarto.org/
   Specifically for the book format: https://quarto.org/docs/books/
3. You can click the Render button above the editor window in any Quarto
   markdown file to see the resulting output in the viewer pane. You can also
   open the local copy of the web page in your favorite browser (there is a
   button for this above the preview contents).
4. When you have completed a chunk of work (e.g. written a section or completed
   an exercise), you should commit your work to git and push the results to
   GitHub.

Every time you repeat these steps, you contribute another chunk of work to the
lecture notes and all of us can get the lates version by pulling from GitHub.

If you would like to see your work on the web, ask Dan to deploy it to the
web server. Most likely there will be a staging area where we can test and then
a more polished production web site that we can share with the students. But
initially there is just the one link: https://tildeweb.au.dk/au78495/NLM/


