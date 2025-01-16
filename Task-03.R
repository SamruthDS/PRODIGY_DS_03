# Install required libraries (run this only once)
if (!require("caret")) install.packages("caret", dependencies = TRUE)
if (!require("rpart")) install.packages("rpart")
if (!require("rpart.plot")) install.packages("rpart.plot")

# Load necessary libraries
library(dplyr)
library(caret)
library(rpart)
library(rpart.plot)

# Load the dataset
bank_data <- read.csv("C:/Users/ASUS/Downloads/bank-full.csv", sep = ";")  # Update file path if needed

# View the structure of the dataset
str(bank_data)

# 1. Data Preprocessing
# Convert the target variable ('y') to a factor
bank_data$y <- as.factor(bank_data$y)

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_index <- createDataPartition(bank_data$y, p = 0.8, list = FALSE)
train_data <- bank_data[train_index, ]
test_data <- bank_data[-train_index, ]

# 2. Build the Decision Tree Classifier
# Train the decision tree model
decision_tree <- rpart(y ~ ., data = train_data, method = "class")

# Visualize the decision tree
rpart.plot(decision_tree, main = "Decision Tree for Bank Marketing Data")

# 3. Evaluate the Model
# Make predictions on the test data
predictions <- predict(decision_tree, test_data, type = "class")

# Confusion Matrix
conf_matrix <- confusionMatrix(predictions, test_data$y)
print(conf_matrix)

# 4. Insights
# Print variable importance
importance <- varImp(decision_tree)
print(importance)
