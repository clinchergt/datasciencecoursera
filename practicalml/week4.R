library(ElemStatLearn)
library(caret)

data(vowel.train)

data(vowel.test)

vowel.train$y = factor(vowel.train$y)
vowel.test$y = factor(vowel.test$y)
set.seed(33833)

gbmVowel <- train(vowel.train[-1], vowel.train$y, method="gbm")
rfVowel <- train(vowel.train[-1], vowel.train$y, method="rf")

gbmpreds <- predict(gbmVowel, vowel.test[-1])
rfpreds <- predict(rfVowel, vowel.test[-1])

agreed <- sum(gbmpreds == rfpreds)/length(gbmpreds) # .6796

confusionMatrix(vowel.test$y, gbmpreds) #.5216
confusionMatrix(vowel.test$y, rfpreds) #.6082

###2
library(caret)
library(gbm)

set.seed(3433)
library(AppliedPredictiveModeling)

data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

rfAD <- train(diagnosis ~ ., data = training, method = "rf")
gbmAD <- train(diagnosis ~ ., data = training, method = "gbm")
ldaAD <- train(diagnosis ~ ., data = training, method = "lda")

rfpreds <- predict(rfAD, testing)
gbmpreds <- predict(gbmAD, testing)
ldapreds <- predict(ldaAD, testing)

confusionMatrix(rfpreds, reference = testing$diagnosis) # 7805
confusionMatrix(gbmpreds, reference = testing$diagnosis) # 8293
confusionMatrix(ldapreds, reference = testing$diagnosis) # 7683

ensenmbleData <- data.frame(diagnosis=testing$diagnosis,
                            rf=rfpreds,
                            gbm=gbmpreds,
                            lda=ldapreds)
rfEnsemble <- train(diagnosis ~ ., data=ensenmbleData, method="rf")
ensenmblePreds <- predict(rfEnsemble, ensenmbleData)

confusionMatrix(testing$diagnosis, ensenmblePreds) # 8293

###3
set.seed(3523)
install.packages("elasticnet")
library(elasticnet)
library(AppliedPredictiveModeling)
install.packages()
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

enetty <- enet(data.matrix(training[-9]), training$CompressiveStrength, trace=T)

plot(enetty, xvar = "penalty", use.color = T)

### 4
setwd("~/git/datasciencecoursera/practicalml")
library(lubridate) # For year() function below
install.packages("forecast")
library(forecast)

dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

forecastmodel <- bats(tstrain)
forecasts <- forecast(forecastmodel, h=235)

testing

## 5
library(e1071)
library(ModelMetrics)
set.seed(3523)

library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[ -inTrain,]

set.seed(325)

compSt <- svm(CompressiveStrength ~ ., training)
compstpreds <- predict(compSt, testing)

rmse(testing$CompressiveStrength, compstpreds)

