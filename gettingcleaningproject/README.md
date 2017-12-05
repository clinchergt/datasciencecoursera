# Getting and Cleaning Data Project

First thing I do in the script is load up dplyr (after checking it's available, if not, then it is installed).

Once dplyr's been installed, I read the files and keep some of them handy for later on. The actual data I concatenate using rbind, and once that's done I merge them into a single data frame using cbind. All of this is done to accomplish step 1 of the project.

Step 2 is straight forward, I simply select the columns that interest me and the ones that include the word `mean` and `std` in their name.

Step 3 is just as straight forward, I use the file I read at the start and assign the value of the current movements to its correspendent name in that data frame. This results in getting the names for the movements instead of their code.

Step 4 consists of lowering all the cases in the names and substituting all the dots in the names to `""`.

Step 5 groups by subject and movement and then gets the average for all the columns with the `summarize_all` function.

Finally, I write the tidy dataset to a file called `tidydata.txt`.
