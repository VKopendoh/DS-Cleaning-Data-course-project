==================================================================
Tidy and transformed DATA from source data. 
==================================================================
'Source data' called:
Human Activity Recognition Using Smartphones Dataset
Version 1.0

and you can find it here: </br>
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


#### Data file: 'data.csv'
Data was created by merging 'test' and 'train' data from source, complete description of this proccess you can read at Readme.md file in this repository. And you can create it automaticaly with starting a script 'run_analysis.R' from this repo (note: you need have an internet connection than running this script).

#### Variables:
- ***'activity'*** a *'character'* name of activity (*walking, walking_upstairs, walking_downstairs, sittings, standing, laying*).
- ***'subjectID'*** an *'integer'* ID of obtained subject in range 1 to 30.
- ***'Averege Featured variables'*** a *'double'* average of each 'Featured variable' from 'Source Data' (note: only for Mean and Standard deviation variables in source) for each activity and each subject ('AVG' prefix means avarege). Names of variables are: 


---------------------------------------

> AVGtimeBodyAccXYZ </br>
AVGtimeGravityAccXYZ</br>
AVGtimeBodyAccJerkXYZ</br>
AVGtimeBodyGyroXYZ</br>
AVGtimeBodyGyroJerkXYZ</br>
AVGtimeBodyAccMag</br>
AVGtimeGravityAccMag</br>
AVGtimeBodyAccJerkMag</br>
AVGtimeBodyGyroMag</br>
AVGtimeBodyGyroJerkMag</br>
AVGfrequencyBodyAcc-XYZ</br>
AVGfrequencyBodyAccJerkXYZ</br>
AVGfrequencyBodyGyroXYZ</br>
AVGfrequencyBodyAccMag</br>
AVGfrequencyBodyAccJerkMag</br>
AVGfrequencyBodyGyroMag</br>
AVGfrequencyBodyGyroJerkMag</br>

Plus adding of 'Mean' or 'Std' according that were estimated from these signals are:</br>
> 'Mean': Mean value</br>
'Std': Standard deviation

#### Description of 'Featured variable' from 'Source Data' following below.

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

> tBodyAcc-XYZ</br>
tGravityAcc-XYZ</br>
tBodyAccJerk-XYZ</br>
tBodyGyro-XYZ</br>
tBodyGyroJerk-XYZ</br>
tBodyAccMag</br>
tGravityAccMag</br>
tBodyAccJerkMag</br>
tBodyGyroMag</br>
tBodyGyroJerkMag</br>
fBodyAcc-XYZ</br>
fBodyAccJerk-XYZ</br>
fBodyGyro-XYZ</br>
fBodyAccMag</br>
fBodyAccJerkMag</br>
fBodyGyroMag</br>
fBodyGyroJerkMag</br>


--------------------------------------

The set of variables that were estimated from these signals are: 

> mean(): Mean value</br>
std(): Standard deviation</br>
mad(): Median absolute deviation </br>
max(): Largest value in array</br>
min(): Smallest value in array</br>
sma(): Signal magnitude area</br>
energy(): Energy measure. Sum of the squares divided by the number of values. </br>
iqr(): Interquartile range </br>
entropy(): Signal entropy</br>
arCoeff(): Autorregresion coefficients with Burg order equal to 4</br>
correlation(): correlation coefficient between two signals</br>
maxInds(): index of the frequency component with largest magnitude</br>
meanFreq(): Weighted average of the frequency components to obtain a mean frequency</br>
skewness(): skewness of the frequency domain signal </br>
kurtosis(): kurtosis of the frequency domain signal </br>
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.</br>
angle(): Angle between to vectors.</br>


------------------------------------------------

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:</br>

> gravityMean</br>
tBodyAccMean</br>
tBodyAccJerkMean</br>
tBodyGyroMean</br>
tBodyGyroJerkMean</br>

The complete list of variables of each feature vector is available in 'features.txt'


 
