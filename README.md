# SamsungAccelerometer
Averages of Accelerometer data for 30 Subjects in 6 activities

The code first needs you to set your working directory, and load (or install if you have to) the stringr package. After that, it's straightforward:

It loads the variable names to the matrix "features" and gets rid of the numbers and spaces in the beggining of the names

It loads the test and train data, splits in in 561 columns and adds the subjects and avtivity labels for each observation

It joins the test and train observations

It names the columns with the features matrix and selects those that had "mean" or "std" (standard deviation) in the variable name, subsetting to keep only these columns (79) and the subject and activity code

It names the activities according to the instructions of the data compilers: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. From Smartlab - Non Linear Complex Systems Laboratory

And lastly, for each subject and each activity it computes the average of each of the variables in the 79 columns, and it saves this table of averages to a .txt
