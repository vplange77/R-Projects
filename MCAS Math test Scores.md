## Data Source
Our dataset was retrieved from Boston Public Schools Office of Data and Accountability. The raw dataset
contains 28 variables including continuous and categorical variables. We chose 11 variables of interest to
determine if there was any correlation that existed between the variables and MCAS math scores.

![screen shot 2018-09-20 at 3 09 28 pm](https://user-images.githubusercontent.com/31625655/45841284-4ec80a00-bce7-11e8-8abe-504e60ecf08d.png)

Fig.1

For further regression training, we also converted some continuous variables to categorical.

![screen shot 2018-09-20 at 3 38 25 pm](https://user-images.githubusercontent.com/31625655/45842649-4ffb3600-bceb-11e8-8cfd-3bc15b6ba6c7.png)

Fig.2

## Research Questions
Making reference to the “No Child Left Behind Act” authorized by the Department of Education, and
with our aim of supporting these districts in an effort to solve the education inequalities, we developed
research questions below which could help us achieve this:
What are the factors that impact student MCAS scores?

We also came up with two sub questions:
1. How does funding impact students’ MCAS math scores?
2. Is there any correlation between Math scores and other variables of interest?


## Exploratory Analysis
For our analysis, we began by exploring the dataset. We created scatter plots to visualize the data to
decide what methodology to use, and to see if we can observe patterns in the dataset.

![screen shot 2018-09-20 at 3 39 32 pm](https://user-images.githubusercontent.com/31625655/45842752-9ea8d000-bceb-11e8-929b-cabbe6370502.png)

Fig 3

From the plot in Fig 3, we can tell that there exists a positively linear relationship between “mathscore”
and “average salary”.

![screen shot 2018-09-20 at 3 39 42 pm](https://user-images.githubusercontent.com/31625655/45842947-2b538e00-bcec-11e8-9ace-620c1714bef4.png)

Fig 4

Fig 4 tells us that mathscore and percentage of minority have a negatively linear relationship. Thus, we
determined that funding does have an effect on MCAS math scores, and we would like to know whether
the impact is significant.

## Methodology

We applied various statistical and data mining techniques such as Hypothesis Testing, Linear Regression,
and Logistic Regression. The following goes into more detail on how we used these techniques to answer
our research questions:
# I. Hypothesis Testing
We are assuming that district funding for high math score students is not greater than the district
funding for low score students. Hence, our null hypothesis is “there is no significant impact in a
students performance based on funding”, whereas, our alternative hypothesis is “there is a
significant impact in a students performance based on funding”.

* H​0: mathhigher$avg_salary <= mathlower$avg_salary

* H​a: mathhigher$avg_salary > mathlower$avg_salary

Using a two sample t-test function in R and an alternative = greater parameter, results show
that indeed funding has a statistically significant impact on students’ performance on the MCAS
Math test. From the results, we obtained a p-value of 2.23e-05. Hence, we will reject the null
hypothesis that there is no significant impact in a students performance based on funding. We can
conclude that the higher the district funding, the higher the students’ performance on the MCAS
Math test.

# II. Linear Regression
From the hypothesis test, we’ve been able to confirm that funding has a statistically significant
impact on students’ performance on the MCAS Math test. Next, we would like to identify other
variables that have strong correlation with MCAS Math scores. We started by applying Linear
Regression technique to the complete dataset. Our original model resulted in an Adjusted R^2 of76%. After applying the stepwise selection approach, we got a reduced model with the same
adjusted R^2 of 76%. From this model, we can see that percentage of minorities from each district,
percentage of students who graduate within four years of high school from each district, and
percentage of funding from each district, are significant factors for predicting MCAS math scores.
The adjusted R^2 in our final model means that 76% of the variation in math scores is explained by
the variation in the predictor variables suggested by the stepAIC model below:
Final Model: mathscore ~ pct_minority + pct_fouryear + avg_salary

![screen shot 2018-09-20 at 3 39 51 pm](https://user-images.githubusercontent.com/31625655/45843010-5ccc5980-bcec-11e8-8603-c918345b4874.png)

Fig 5

To evaluate the performance of the final model, we randomly split the dataset into training (70%)
and testing (30%) datasets. Then we predicted math scores using the test dataset. Model results in
Fig 6 shows an R
2 of 70%, and a low RMSE of 3.89 which suggests that our model is a good
model. We believe that the model may perform better with a larger sample size.

![screen shot 2018-09-20 at 3 40 01 pm](https://user-images.githubusercontent.com/31625655/45843019-65249480-bcec-11e8-8aa6-21ecca3cd40c.png)
Fig 6

III. Logistic Regression
From the linear regression model, we understand that percentage of minority, percentage of
students who graduate within four years of high school, and percentage of funding impact
students’ math scores. Next, we want to also determine whether gender and location (rural vs.
urban) both impact the likelihood of a student passing the MCAS Math test. Since, our new
dependent variable is binary (i.e pass/fail), we decided to apply logistic regression. We split the
data into 80% training and 20% testing datasets. The proportion of the class in both training and
testing datasets is shown in Fig 7.

![screen shot 2018-09-20 at 3 40 07 pm](https://user-images.githubusercontent.com/31625655/45843026-6d7ccf80-bcec-11e8-98ad-301d0a039c0f.png)
Fig 7

The result from our logistic regression model shows that location has a statistically significant
relation with Math performance followed by funding. As we can see in Fig 8, gender is not a very
significant factor for predicting students’ performance.

![screen shot 2018-09-20 at 3 39 51 pm](https://user-images.githubusercontent.com/31625655/45843010-5ccc5980-bcec-11e8-8603-c918345b4874.png)

Fig 8

Based on the above result in Fig 8, we were also curious to know the odds ratio of students in
urban vs. rural districts passing the MCAS Math test. We created a new model with y (pass/fail)
as dependent variable, and location (urban/rural) as the independent variable. To calculate the
odds ratio, we first calculated the odds that a student from urban/rural school district would pass
the MCAS Math test. From Fig 9, we can see that rural districts have 12.71 times or 71% greater
odds of passing the MCAS Math test, whereas, urban districts have 0.079 or 8% lesser odds of
passing the MCAS Math test.


Fig 9


We applied various metrics such as variance inflation factor (vif), misclassification error rate,
concordance, sensitivity, and specificity to evaluate the performance of our logistic regression
model. As shown in Fig 10, a vif < 2 (also less than the threshold of 5) indicates that there is little
to no collinearity between the independent variables.


Fig 10

Furthermore, a misclassification error rate of 4% and concordance (i.e pairs whose actual 1s is
greater than actual 0s) of 83% suggests that our model is a good quality model. We obtained a
100% sensitivity (i.e actual 1s predicted as 1s by the model) and 33% specificity (i.e actual 0s
predicted as 0s by the model) as seen in Fig 11. Overall, our model performs very well, especially
when predicting which districts have higher likelihood for success on the MCAS Math test,
however, the model did not perform well when it comes to predicting failures. To improve our
model, we can try to reduce the amount of false negatives (i.e fails classified as passes) by

applying a cost matrix where false negatives are weighted more heavily than false positives,
especially if predicting failures is paramount.
Fig 11
In addition, an Area Under ROC Curve of 89% suggests that our model is a good model and has
good prediction capability.
Fig 12


# Conclusion
Using various statistical and data mining techniques, we are able to answer our research questions.
Specifically, we have discovered that district funding, as well as percentage of minorities in each district,
and district location (urban/rural), does indeed impact MCAS Math test results. With this information,
Massachusetts Department of Education can begin to identify gaps based on district funding, minority
groups, location (urban/rural), and work towards resolving this problem of inequality in Massachusetts’
education system.

