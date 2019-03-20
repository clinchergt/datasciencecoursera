library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
segmentationOriginal <- setDT(segmentationOriginal)
segmentationOriginal$Case
train <- copy(segmentationOriginal[Case == "Train"])
test <- copy(segmentationOriginal[Case == "Test"])

set.seed(125)

modelo <- rpart(Class ~ ., train)
rpart.plot(modelo)

modelo

install.packages("pgmm")
library(pgmm)
data(olive)
olive = olive[,-1]
areaoliv <- rpart(Area ~ ., olive)
rpart.plot(areaoliv)

newdata = as.data.frame(t(colMeans(olive)))
predict(areaoliv, newdata)

mean(olive$Area)


install.packages("ElemStatLearn")
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)
chdModel <- glm(chd ~ age + alcohol + obesity + tobacco + typea + ldl, family = "binomial", trainSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

trainpreds <- predict(chdModel, trainSA)
testpreds <- predict(chdModel, testSA)

missClass(trainSA$chd, trainpreds)
missClass(testSA$chd, testpreds)


install.packages("randomForest")
library(randomForest)
library(caret)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y = factor(vowel.train$y)
vowel.test$y = factor(vowel.test$y)
set.seed(33833)

vowelModel <- randomForest(y ~ ., vowel.train)
vowelModel$importance
setDT(varImp(vowelModel))[order(-Overall)]

