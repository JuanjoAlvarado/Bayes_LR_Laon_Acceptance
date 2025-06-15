# Install and Load Packages Needed ----
install.packages("tidybayes") # Work with the Bayes model results  
install.packages("patchwork") # Combine plots
install.packages("gt")        # Creates visually attractive resume tables 
install.packages("brms")      # Markov Chains Monte Carlo engine (Stan)

library(tidyverse)
library(tidybayes)
library(patchwork)
library(gt)
library(brms)

# Optional: brms could be executing faster without compromising the PC stability
options(mc.cores = parallel::detectCores() - 1) 

# Data Load and Exploration (EDA) ----
bank_data <- read_csv("Bank_Personal_Loan_Modelling.csv")

# Data Cleaning and Pre Process
loan <- bank_data %>% 
  janitor::clean_names() #clean column names

loan <- loan %>%  #Converting categorical variables to factors
  mutate(
    education = factor(education, levels = c(1, 2, 3), labels = c("Undergraduate", "Graduate", "Professional")),
    securities_account = factor(securities_account, levels = c(0, 1), labels = c("No", "Yes")),
    cd_account = factor(cd_account, levels = c(0, 1), labels = c("No", "Yes")),
    online = factor(online, levels = c(0, 1), labels = c("No", "Yes")),
    credit_card = factor(credit_card, levels = c(0, 1), labels = c("No", "Yes")),
    personal_loan = factor(personal_loan, levels = c(0, 1), labels = c("No", "Yes")) #Target Variable
  ) %>% 
  select(-id, -zip_code)

glimpse(loan)  #Check the data structure

# Data Visualization Examples
plot_1st <- ggplot(loan, aes(x = personal_loan, y = family, fill = personal_loan)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Family size vs Loan Acceptance",
    x = "Accepted the loan?",
    y = "Number of members"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

plot_2nd <- ggplot(loan, aes(x = education, fill = personal_loan)) +
  geom_bar(position = "fill") +
  labs(
    title = "Educational Level vs Loan Acceptance",
    x = "Educational Level",
    y = "Proportion"
  ) +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

plot_1st + plot_2nd #Combine both plots

# Bayesian Model ----
# Priors 
priors <- c(
  set_prior("normal (0, 2.5)", class = "b"),  #For all the coefficients (columns)
  set_prior("normal (0, 5)", class = "Intercept") #For personal_loan (intercept)
)

# Defining and adjusting the model 
loan_model <- brm(
  formula = personal_loan ~ income + family + cc_avg + education + mortgage + credit_card + online,
  data = loan,
  family = bernoulli(link = "logit"),
  prior = priors,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  seed = 001
)

# Model Diagnostic ----
# Visualization: Trace Plot
plot(
  loan_model,
  nvariables = 4,
  ask = FALSE
)

# Model Results ----
# Numeric Resume
summary(loan_model)

# Posterior Distributions Visualization
posterior <- as_draws_df(loan_model)

ggplot(posterior, aes(x = b_income)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Income")

ggplot(posterior, aes(x = b_family)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Family")

ggplot(posterior, aes(x = b_cc_avg)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: cc_avg")

ggplot(posterior, aes(x = b_educationGraduate)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Education Level - Graduate")

ggplot(posterior, aes(x = b_educationProfessional)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Education Level - Profesisonal")

ggplot(posterior, aes(x = b_mortgage)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Mortgage")

ggplot(posterior, aes(x = b_credit_cardYes)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Has a Credit Card")

ggplot(posterior, aes(x = b_onlineYes)) +
  stat_halfeye() +
  labs(title = "Posterior Distribution: Use online service")

# Odd Ratio Conversion
loan_model %>% 
  gather_draws(b_Intercept, b_income, b_family, `b_education.*`, regex = TRUE) %>% 
  mutate(odds_ratio = exp(.value)) %>%
  reframe(
    median_or= median(odds_ratio),
    lower_ci = quantile(odds_ratio, 0.025),
    upper_ci = quantile(odds_ratio, 0.975)
  ) %>%
  distinct() %>% 
  gt() %>% 
  tab_header(title = "Model Odd Ratios Resume") %>% 
  fmt_number(columns = c(median_or, lower_ci, upper_ci), decimals = 2)
 
# Predictive Performance Evaluation ----
# Predictive Posterior Check (PPC)
pp_check(loan_model, ndraws = 100)

# ROC and AUC Curve
pred_prob <- posterior_epred(loan_model)

prob_mean <- apply(pred_prob, 2, mean)

results <- tibble(
  observed = loan_model$data$personal_loan,
  predicted_prob = prob_mean
)

roc_curve <- pROC::roc(observed ~ predicted_prob, data = results) 
auc_value <- pROC::auc(roc_curve)

print(paste("AUC:", round(auc_value, 3)))

# Visualization
pROC::ggroc(roc_curve) +
  labs(
    title = "Loan Model ROC Curve",
    subtitle = paste("AUC:", round(auc_value, 3))
  ) +
  theme_minimal()

