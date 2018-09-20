############################
## Initializing Workspace ##
############################

## Function - To Install & Load Packages ##
package_install_load <- function(package) {
  
  if (!require(package, character.only = TRUE)) {
    invisible(install.packages(package, dep = TRUE))
    if (!require(package, character.only = TRUE)) {
      install.packages(package)
      library(package)
      if (!require(package, character.only = TRUE)) {
        print(paste("Package Not Found : ", package))
      }
    }
  }
  else{
    print(paste("Package Loaded : ", package ))
  }
}

## Function - Set Working Directory ##
set_working_directory <- function(dir_path) {
  
  if(!file.exists(dir_path)){ # Check If Directory Exist
    dir.create(dir_path) # Create Directory
  }
  
  setwd(dir_path) #Set Working Directory
  print(paste("Working Directory Set to :",dir_path)) # Print Message
}

## Block - Load Required Packages ##
packages <- c("plyr", "datasets", "ggplot2",
              "mlbench", "dplyr","corrplot","RColorBrewer", "caTools" )

## Execute - The Package Load Install Function ##
invisible(lapply(packages, package_install_load))

## Block - Setting Working Directory ##
set_working_directory("//Users/victoriaplange/Desktop/intermediate analytics");


data3 <- read.csv("assignment3.csv")

## Examine Weather Dataset ##
dim(data3)
head(data3)
str(data3)
summary(data3)
View(data3)


#Split the data
set.seed(12345)

data3_split <- sample.split(data3, SplitRatio =0.75)
data3_train <- subset(data3, data3_split==TRUE) # training data
data3_test <- subset(data3, data3_split==FALSE)  #testing data



#checking dimensions after splitting

dim(data3)
dim(data3_train)
dim(data3_test)

names(data3)

#a) #Fit a linear regression model with our training data set:
lm_fit=lm(EP~., data=data3_train)
summary(lm_fit)

#Remove all variables with low p values
#Remove dc from model 
lm_fit=lm(EP~wind + pressure + humidity + FFMC + visability + DMC + DC + ISI, data3=data3_train)
summary(lm_fit)

#remove humidity
lm_fit=lm(EP~wind + pressure + FFMC + visability + DMC + ISI, data3=data3_train)
summary(lm_fit)

#Till you are left with original single variable model
reducedmodel = lm(EP~pressure  , data=data3_train)
summary(reducedmodel)

#Anova
anova(reducedmodel, lm_fit)
#we fail to reject the null hypothesis because the p value is high. Thus, 
#the one with only the variable pressure is the better model.

#Y = β0 + β1X1 + β2X2 + ε
    = -9.881e+02 + 4.573e-01(wind) +1.389+00(pressure) + -1.238e-01(humidity) + 1.083e-01(FFMC) +2.770e-01(visability)
      1.497e-02(DMC) + -4.1610e-04(DC) + 3.230e-02 + 15.32

#Y = β0 + β1X1 + ε
      = -969.1284 + 1.4061 + 15.04
      #pvalues, paramter estimates, standard error for each x value. 
      

#model fit statistics for each model from the training data
#predicting the values 
data_test$prd_EP <- predict(reducedmodel, data3_test)
predicted_full <- predict(lm_fit, newdata = test)
predicted_model <- predict(reducedmodel, newdata = test)

#compare predicted values to actual plot using r2 values
#calculate r2
SSE <- sum((test$EP - predicted_ys) ^ 2)
SST <- sum((test$EP - mean(test$EP)) ^ 2)
r2 <- 1 - SSE/SST
r2

names(data_test)

ggplot(data=data_test,aes(x=EP,y=prd_EP))+
  geom_point(alpha=1/2,position="jitter")+ 
  geom_smooth() +
 scale_x_continuous(breaks=seq(400,500,5)) +
 scale_y_continuous(breaks=seq(400,500,5)) +
  xlab("Actual EP") + 
  ylab("Predicted EP") +
  theme_bw()


#Our observed values of Y are just the values of EP in our test data:
observed_EP <- test$EP

#We can compare the first few predicted_ys to observed ys:
head(lm_fit, 1)
head(observed_EP)


#RMSE

data_rmse <- sqrt(mean(data_test$EP-data_test$prd_EP)^2)
data_rmse


#c 	Use the stepAIC() function to implement backward selection (starting with the full model)
fit <- lm(EP~.,data=data)
summary(fit)
step <- stepAIC(fit, direction="backward")



##########2a Utilize Lasso to fit a model with all X variables to predict our 
#outcome variable, energy production#################

library(glmnet)

x <- model.matrix(EP~., data3)[,-1]
y <- data3$EP

#four objects
#Split the data
set.seed(12345)

x_split <- sample.split(data3, SplitRatio =0.75)
x_train <- subset(data3, x_split==TRUE)
x_test <- subset(data3, x_split==FALSE)

y_split <- sample.split(data3, SplitRatio =0.75)
y_train <- subset(data3, y_split==TRUE)
y_test <- subset(data3, y_split==FALSE)

x_train <- model.matrix(EP~.,data3_train )[,-1] #this transforms x (VARIABLES)from a variable within a dataframe into a matrix
y_train <- data3_train$EP # changes a variable into  avectr

x_test <- model.matrix(EP~., data3_test)
y_test <- data3_test$EP

# Fit the lasso model cv.glmnet and glmnet- X
set.seed(12345)
cv_out <- cv.glmnet(x=x_train, y=y_train, alpha = 1, nlambda = 1000)

glmnet(x_train, y_train, alpha=1, nlambda=100, lambda.min.ratio=0.0001)
plot.cv.glmnet(cv_out) #helps you find best fitting parameter and lambda estimates
ridge.mod <- glmnet(x_train, y_train, alpha=1, nlambda=100, lambda.min.ratio=0.0001)
ridge.mod
plot(cv_out)
best.lambda <- cv_out$lambda.min
best.lambda #[1] 1.5057


#assign this model and the minimum lambda to the test data

x_test <- model.matrix(EP~., test)[,-1] #this transforms x from a variable within a dataframe into a matrix
y_test <- test$EP

y_predicted <- predict(ridge.mod, s = best.lambda, newx = x_test)
y_predicted
y_test


#Let's assess our prediction accuracy/error via:
# Sum of Squares Total and Error
sst <- sum(y_test^2)
sse <- sum((y_predicted - y_test)^2)

# R squared
rsq <- 1 - sse / sst
rsq

#RMSE

data_rmse <- sqrt(mean(data_test$EP-data_test$prd_EP)^2)
data_rmse



##############Question 3 PCR Model

install.packages("pls")
library(pls)

#Fit the PCR model:
require(pls)
set.seed (1000)
pcr_model <- pcr(EP~., data = data3_train, scale = TRUE, validation = "CV")

#get results of the PCR model:
summary(pcr_model)

#View results of the PCR model visually:
# Plot the root mean squared error
validationplot(pcr_model, val.type = c("RMSEP"))

# Plot the mean squared error:
validationplot(pcr_model, val.type = c("MSEP"))

# Plot the R-squared:
validationplot(pcr_model, val.type = c("R2"))


#Seeing how our 3 components perform with train/test data set

pcr_model <- pcr(EP~., data = data3_train,scale =TRUE, validation = "CV")
pcr_pred <- predict(pcr_model, test, ncomp = 3)
mean((pcr_pred - test$EP)^2)
#mean=269.5984

plot(pcr_model)

#let's compare this to what we would have got with regular linear regression with all of the variables:
ols <- lm(EP~., data = data3_train)
ols_pred <- predict(ols, test)
mean((ols_pred - test$EP)^2)
#mean=233.9174

sst <- sum(y_test^2)
sse <- sum((y_predicted - y_test)^2)

# R squared
rsq <- 1 - sse / sst
rsq

#RMSE
data_rmse <- sqrt(mean(data_test$EP-data_test$prd_EP)^2)
data_rmse