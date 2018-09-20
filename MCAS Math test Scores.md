# Introduction

MCAS is a cumulative test taken by all high school students in the state of Massachusetts. It was
established in 1993 under the Massachusetts Education Reform Act, which coerced all students who were
enrolled in tested grades within any publicly funded school in Massachusetts, to partake in the test. The
test is taken from grade 3 up until grade 12, and is deemed as the lowest level of test taking for any high
school student to graduate. It is thus easier in comparison to other standardized tests such as the SAT and
ACT. With a total of 280, the average student is to score above 240 whereas students with learning,
physical or mental disabilities could score between 220 and 238. MCAS encompasses various subjects
such as technology, engineering history amongst others, but Math is the only test taken each year from
grade 3. This prompted us to dig deeper into this subject as there was more data available on math tests.
Additionally, according to the National Assessment of Educational Progress, Massachusetts ranks the
highest in mathematical performance amongst high school students. (MassBudget, 2010).
We obtained MCAS data from the Boston Public Schools website, which consists of variables such as
funding for each district, school enrollment, and the location of the districts (rural or urban settings)
amongst others. However, upon our analysis of the various variables in the data, we observed three main
issues which are that MCAS passing rates and how funding varies across districts within Massachusetts.
In addition, there seems to be a sign of educational inequality which might be affecting students’
performance. Generally, students that tend to be within rural districts, where living standards and income
are low, have no motivation to be in school or partake in any standardized tests. There is no incentive to
establish a brighter future due to their surroundings. It has also been rumored that educational funding
tends to be allocated to urban areas to continue to facilitate development and enhance course programs
within such schools. Thus, our goal for this project is to understand factors that affect students’ MCAS
Math scores with the aim of aiding administrators to focus on improving factors that have an impact on
MCAS Math scores. Through this, we hope to solve the problem of education inequalities in
Massachusetts, and hopefully work towards achieving a 100% success rate in math tests for all districts in
Massachusetts.


## Data Source
Our dataset was retrieved from Boston Public Schools Office of Data and Accountability. The raw dataset
contains 28 variables including continuous and categorical variables. We chose 11 variables of interest to
determine if there was any correlation that existed between the variables and MCAS math scores.

![screen shot 2018-09-20 at 3 09 28 pm](https://user-images.githubusercontent.com/31625655/45841284-4ec80a00-bce7-11e8-8abe-504e60ecf08d.png)

For further regression training, we also converted some continuous variables to categorical.

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
Fig 3
From the plot in Fig 3, we can tell that there exists a positively linear relationship between “mathscore”
and “average salary”.
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

Fig 5
To evaluate the performance of the final model, we randomly split the dataset into training (70%)
and testing (30%) datasets. Then we predicted math scores using the test dataset. Model results in
Fig 6 shows an R
2 of 70%, and a low RMSE of 3.89 which suggests that our model is a good
model. We believe that the model may perform better with a larger sample size.
Fig 6

III. Logistic Regression
From the linear regression model, we understand that percentage of minority, percentage of
students who graduate within four years of high school, and percentage of funding impact
students’ math scores. Next, we want to also determine whether gender and location (rural vs.
urban) both impact the likelihood of a student passing the MCAS Math test. Since, our new
dependent variable is binary (i.e pass/fail), we decided to apply logistic regression. We split the
data into 80% training and 20% testing datasets. The proportion of the class in both training and
testing datasets is shown in Fig 7.
Fig 7
The result from our logistic regression model shows that location has a statistically significant
relation with Math performance followed by funding. As we can see in Fig 8, gender is not a very
significant factor for predicting students’ performance.
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

