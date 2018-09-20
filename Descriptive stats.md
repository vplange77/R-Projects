# Question 1
Download the attached dataset “assignment1.csv, set your working directly to the location of the file, and import the dataset using R code. Using descriptive statistics, visualize this data numerically and graphically. In particular, please provide summary statistics (mean, median, standard deviation, min, max, Q1, and Q3) for variable “Sepal.Width”. Also, please create a histogram for “Sepal.Width”. You can use the following resource as a guide: section 2.5 (p. 15) and 3.5 (p.25) from “Using R for Data Analysis and Graphics.”

# Solution
 
![image](https://user-images.githubusercontent.com/31625655/45841797-e0844700-bce8-11e8-9a74-5112eef03a88.png)
  
Fig.1.1

 ![image](https://user-images.githubusercontent.com/31625655/45841804-e4b06480-bce8-11e8-91aa-f76117f832c2.png)

Fig.1.2

 ![image](https://user-images.githubusercontent.com/31625655/45841808-e8dc8200-bce8-11e8-8cd8-0c21fae39db2.png)
 
 Fig.1.3

Fig.1.1 provides a summary of our data set for Iris flower species- setosa, versicolor and virginica. The summary function in R displays the minimum, maximum, first quartile, third quartile, median and mean of the column within each data set. For Sepal.Width, we found the mean and median to be close together, with the mean being slightly larger than the median (3.057) allowing us to anticipate a skewed right distribution. The standard deviation measures how spread out our values are from the mean and if they are further from the mean, it shows a higher variation in the data set. Within Sepal.Width, we determined a stdev of 0.4 telling us that are data points lie closer to the mean. The data was then visualized into a histogram via ggplot package in R. A histogram represents an accurate distribution and depiction of our numerical data. Fig 1.3 shows the histogram for Sepal.Width and it is a right skewed distribution. We see that we have about 26 species with a sepal width of 3 and between 8 and roughly 18 species with a width between 2.5 and 3.7. The plant width size determines the leaf size and tells us how the leaves ability to absorb light which is an essential factor for their growth. We can ultimately determine from the data that the plants with a sepal width of 3.0 and above would have more energy to process food. 

# Question 2&3
Using  height_weight_byGender.csv data file, plot a histogram of men’s and women’s height.
Then, again using the height_weight_byGender.csv file, plot a scatterplot of height by weight for either men or women using the plot() R function.

# Solution
 
 ![image](https://user-images.githubusercontent.com/31625655/45841815-ed089f80-bce8-11e8-8755-6183806e177a.png)
 
Fig.1.4
 
 ![image](https://user-images.githubusercontent.com/31625655/45841819-eed26300-bce8-11e8-9158-0be77710fbcb.png)
 
Fig.1.5
 
 ![image](https://user-images.githubusercontent.com/31625655/45841822-f1cd5380-bce8-11e8-8dc2-f60b7f06b695.png)

Fig.1.6
 
![image](https://user-images.githubusercontent.com/31625655/45841825-f4c84400-bce8-11e8-8da0-57ac0d1b21bc.png)

Fig.1.7

![image](https://user-images.githubusercontent.com/31625655/45841831-f7c33480-bce8-11e8-8eeb-6f9c462ab8f6.png)

Fig.1.8

Fig.1.5 shows a summary of our dataset, height_weight_bygender which tells us different male and female heights and their corresponding weights. The name function gives us a list of the column names within the data set namely Gender, Height..inches, and Weight.. lbs. Using ggplot package in R, we plot a histogram to visualize the summary of height in inches for both males and females shown in Fig.1.6. We can tell from the image that males have a higher height in inches compared to females. When this same data is translated into a scatter plot, as seen in Fig.1.8 we determine a correlation and a positive linear relationship between height and weight, thus as the height increases the weight also increase. However, this is not so linear based on the fact that the line does not go through the points. We also detected the existence of outliers, which has had an effect on the median of the data and thus the skewness. The outliers also determine that as the height increases rapidly, the weight also increases but at a slower rate.

# Question 4
Descriptive statistics is all about describing a sample of data (or a population). Above, you utilized descriptive statistics to describe the height and weight of individuals within the “height_weight” dataset. What is an example of a statistical inference question we may ask next?

# Solution
Inferential statistics is when we have a limited amount of data and can use that to make assumptions about the entire population. Given the dataset on weight and height of males and females within a given location, we can determine that an increase in height and a slow increase in weight can tell us that there is an underlying factor causing the slow growth in weight. Perhaps a malnourished diet, where certain nutrients for weight gain and strength are absent, could affect the weight gain in both males and females. 
