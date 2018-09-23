
library("openxlsx")
#importing data
poverty <- read.csv("datasetforCS112.csv", dec = ".", stringsAsFactors = FALSE)
str(poverty)

# remove rows with empty project.type
poverty <- poverty[poverty$project.type != '', ]

#reformatting date consistantly
cols <- c('approval.date', 'implementation.start.date', 
          'original.completion.date', 'revised.completion.date')
for (col in cols){
  poverty[,col] <- as.Date(poverty[,col], format='%d-%b-%y')
}

#reformatting numerics consistantly
## why does cum. disburs & undisbursed change remove decimal?
nums <- c('cumulative.disbursements', 'undisbursed.amount')

for (num in nums){
  poverty[,num] <- as.numeric(poverty[,num], digits = 5)
}

str(poverty)

#my questions to answer: SHE --> 19, 8, 5 --> 10, 8,5 --> 1, 8, 5
#not sure how to convert 19(for "S") to a single digit, so I added it = 10, and then took the number 1 from 10
set.seed(185)
my_questions_are_these <- sort(sample(c(1:10), 3, replace = FALSE))

#my vector yielded questions 1, 6, and 7

#Question 1
##How many unique projects? 
table(poverty$project.type)

# Question 6
## fraction of projects have completion dates that are different from revised completion dates?
## Because used "==" the FALSE number that this code generates gives us the answer to this question
### if was written as "!=" the TRUE number would give the answer to this question
### either way, answer is 3991 projects that do not have the same original and revised completion dates
rev_comp<- table(poverty$original.completion.date == poverty$revised.completion.date)

#then divide by the total number of projects length to get the FRACTION
#looking at the structure, we see there are 6200 total projects 
str(poverty)

#fraction = 0.64, so ~ 2/3
rev_comp[1]/6200

#Question 7
##What does quantile function tell us about the distribution of the project budget in the data set?
##Need to remove NA values to get an answer.
quantile(poverty$project.budget, c(0.25,.5, 0.75), na.rm = TRUE)
