# Dependencies
library(ggplot2)
library(dplyr)

# Read dataset from CSV format
salaries = read.csv('../data/salaries.csv')
print(head(salaries))

# Clean and tidy dataset
# 1. Filter dataset such that remote_ratio is either 0 or 100
salaries <- salaries %>%
    filter(remote_ratio == 0 | remote_ratio == 100)

# # 2. Combine jobs into categories
# pattern <- "\\b(Scientist)\\b"
# filtered_job_titles <- unique(salaries$job_title[grepl(pattern, salaries$job_title)])

# for (title in filtered_job_titles) {
#     print(title)
# }

# Compute estimates of the parameter you identified across your groups. Present this in a table. If relevant, include these estimates in your plot.
salary_estimates <- salaries %>%
  group_by(remote_ratio) %>%
  summarize(
    salary_mean = mean(salary_in_usd, na.rm = TRUE), 
    salary_sd = sd(salary_in_usd, na.rm = TRUE)
  )

print(head(salary_estimates))

# Plot the relevant raw data, tailoring your plot in a way that addresses your question.
ggplot(salaries, aes(x = as.factor(remote_ratio), y = salary_in_usd)) +
  geom_boxplot(fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Salary Comparison by Remote Work Ratio", x = "Remote Ratio", y = "Salary (in USD)", color = "Mean")

