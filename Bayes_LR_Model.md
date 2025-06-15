Personal Loan Acceptance - Bayesian Predictive Analysis
================
Juan José Alvarado

# Introduction

This project aims to identify which factors (predictors) influence the
decision of a financial institution - like a bank - when granting a
personal loan (variable of interest) to its clients. This kind of
information can be used to optimize marketing campaigns, targeting
specific demographics. To do so, a *Bayesian Logistic Regression Model*
was implemented using the R package *“bmrs¨*. The analysis indicated
this predictors as the most significant: *Educational Level (Graduate
and Professional), family size and income*. The AUC (**0.949**) reveals
the model has a great predictive capacity.

## Key Aspects of the Project

- Bayesian Logistic Regression Model (with *brms* package)
- Posterior Distribution and Odds Ratios Analysis and Interpretation
- MCMC chains convergence diagnostics (**R-hat**, **Trace Plots**)
- Model Performance Evaluation using ROC/AUC curve and Posterior
  Predictive Checks
- Cleaning, pre process and data visualization

The bank wants to improve marketing campaigns efficiency when offering
personal loans; instead of reaching out every single client in the data
base (costly) it is needed a way to identify those clients with a higher
probability of accepting a personal loan. The model seeks to create a
profile of the *ideal client*, channeling the marketing efforts and
increase returns.

# Data

Data set was retrieved from the *Kaggle* platform under the name: “[Bank
Personal Loan
Modelling](https://www.kaggle.com/datasets/itsmesunil/bank-loan-modelling)”.
It contains demographic and banking information of 5,000 clients.

## Pre process

- The column names were standardized (easier manipulation)
- Categorical variables were converted to factor type
- *id* and *zip_code* variables were excluded as they are not relevant
  predictors.

<!-- -->

    ## # A tibble: 6 × 12
    ##     age experience income family cc_avg education     mortgage personal_loan
    ##   <dbl>      <dbl>  <dbl>  <dbl>  <dbl> <fct>            <dbl> <fct>        
    ## 1    25          1     49      4    1.6 Undergraduate        0 No           
    ## 2    45         19     34      3    1.5 Undergraduate        0 No           
    ## 3    39         15     11      1    1   Undergraduate        0 No           
    ## 4    35          9    100      1    2.7 Graduate             0 No           
    ## 5    35          8     45      4    1   Graduate             0 No           
    ## 6    37         13     29      4    0.4 Graduate           155 No           
    ## # ℹ 4 more variables: securities_account <fct>, cd_account <fct>, online <fct>,
    ## #   credit_card <fct>

## EDA Visualizations

A brief EDA revealed a rather strong relation between the variables
family size and educational level. As you can observe in the following
graph, the distribution of graduates, professionals and clients with a
*large* family size seems high.

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

# Creating a Model

As the variable of interest (*personal_loan*) contains binary data a
*logistic regression model* (for binary classification) was used. With
limited information and wanting to incorporate prior knowledge, the
Bayesian approach was selected. This helps us to provide a probability
distribution to each model predictor and therefore extract more robust
estimates of uncertainty.

## Priors and Diagnostics

To ensure model regularization and avoid over adjustment, *weakly
informative priors* were used (*Normal(0, 2.5)*) for the coefficients
(predictors). After adjusting the model the MCMC chains convergence was
verified (*R_hat close to 1*) and the following trace graphs didn’t show
any odd pattern(s), we could secure the results reliability.

![Intercept and Predictor 1](model1.png) ![Predictors 2](model2.png)
![Predictor 3](model3.png)

# Results

## Model Odd Ratios

<div id="ffmrlkvxwd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ffmrlkvxwd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#ffmrlkvxwd thead, #ffmrlkvxwd tbody, #ffmrlkvxwd tfoot, #ffmrlkvxwd tr, #ffmrlkvxwd td, #ffmrlkvxwd th {
  border-style: none;
}
&#10;#ffmrlkvxwd p {
  margin: 0;
  padding: 0;
}
&#10;#ffmrlkvxwd .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#ffmrlkvxwd .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#ffmrlkvxwd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#ffmrlkvxwd .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#ffmrlkvxwd .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#ffmrlkvxwd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#ffmrlkvxwd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#ffmrlkvxwd .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#ffmrlkvxwd .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#ffmrlkvxwd .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#ffmrlkvxwd .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#ffmrlkvxwd .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#ffmrlkvxwd .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#ffmrlkvxwd .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#ffmrlkvxwd .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffmrlkvxwd .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#ffmrlkvxwd .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#ffmrlkvxwd .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#ffmrlkvxwd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffmrlkvxwd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#ffmrlkvxwd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffmrlkvxwd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#ffmrlkvxwd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffmrlkvxwd .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ffmrlkvxwd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ffmrlkvxwd .gt_left {
  text-align: left;
}
&#10;#ffmrlkvxwd .gt_center {
  text-align: center;
}
&#10;#ffmrlkvxwd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#ffmrlkvxwd .gt_font_normal {
  font-weight: normal;
}
&#10;#ffmrlkvxwd .gt_font_bold {
  font-weight: bold;
}
&#10;#ffmrlkvxwd .gt_font_italic {
  font-style: italic;
}
&#10;#ffmrlkvxwd .gt_super {
  font-size: 65%;
}
&#10;#ffmrlkvxwd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#ffmrlkvxwd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#ffmrlkvxwd .gt_indent_1 {
  text-indent: 5px;
}
&#10;#ffmrlkvxwd .gt_indent_2 {
  text-indent: 10px;
}
&#10;#ffmrlkvxwd .gt_indent_3 {
  text-indent: 15px;
}
&#10;#ffmrlkvxwd .gt_indent_4 {
  text-indent: 20px;
}
&#10;#ffmrlkvxwd .gt_indent_5 {
  text-indent: 25px;
}
&#10;#ffmrlkvxwd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#ffmrlkvxwd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="4" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Model Odd Ratios Resume</td>
    </tr>
    &#10;    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="a.variable">.variable</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="median_or">median_or</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="lower_ci">lower_ci</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="upper_ci">upper_ci</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers=".variable" class="gt_row gt_left">b_Intercept</td>
<td headers="median_or" class="gt_row gt_right">0.00</td>
<td headers="lower_ci" class="gt_row gt_right">0.00</td>
<td headers="upper_ci" class="gt_row gt_right">0.00</td></tr>
    <tr><td headers=".variable" class="gt_row gt_left">b_educationGraduate</td>
<td headers="median_or" class="gt_row gt_right">50.16</td>
<td headers="lower_ci" class="gt_row gt_right">30.89</td>
<td headers="upper_ci" class="gt_row gt_right">82.07</td></tr>
    <tr><td headers=".variable" class="gt_row gt_left">b_educationProfessional</td>
<td headers="median_or" class="gt_row gt_right">50.58</td>
<td headers="lower_ci" class="gt_row gt_right">31.61</td>
<td headers="upper_ci" class="gt_row gt_right">81.14</td></tr>
    <tr><td headers=".variable" class="gt_row gt_left">b_family</td>
<td headers="median_or" class="gt_row gt_right">1.80</td>
<td headers="lower_ci" class="gt_row gt_right">1.57</td>
<td headers="upper_ci" class="gt_row gt_right">2.08</td></tr>
    <tr><td headers=".variable" class="gt_row gt_left">b_income</td>
<td headers="median_or" class="gt_row gt_right">1.06</td>
<td headers="lower_ci" class="gt_row gt_right">1.06</td>
<td headers="upper_ci" class="gt_row gt_right">1.07</td></tr>
  </tbody>
  &#10;  
</table>
</div>

- Being graduated and professional increases the odds up to **50
  times!** when accepting a personal loan.
- Having one more family member adds up to 80% in the odds also.
- Lastly, clients with relatively high income increases only 6% the odds
  of accepting a personal loan.

## Other Predictors Posterior Distributions

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

# Model Evaluation

The predictive performance of the model was evaluated using the Receiver
Operating Characteristic Curve (ROC) and the Area under that Curve
(AUC). The value of **AUC = 0.9491** indicates a great discriminatory
(clients who accept or don’t) capacity.

<img src="Bayes_LR_Model_files/figure-gfm/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

# Conclusions

The Bayesian approach to the Lineal Regression Model helped constructing
a robust client profile (**highly educated, with “large” family and
above average income**) with a high chance of accepting a personal loan.
A bank’s marketing department could use these kind of modeling results
to segment its clients and focus future campaigns in order to increase
potential investments returns.
