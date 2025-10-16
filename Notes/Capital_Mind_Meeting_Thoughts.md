# 26 March 2025

1. How do they use the system on a day to day basis?

2. Where do they store the data?

3. What is the architecture of the system?

4. What kind of data do you get?

5. What are processing steps involved on raw data?
    - how long for processing? (1 to 2 minutes)
    sometimes you need to redo the processing owing to adjustments

6. What kind of features do you generate?
    - features are generated locally? 
    ()

7. How long does it take to generate the features?

8. What is the flow? -- raw data, compute features from them (this happens asynch), and then you specify portfolio based on features.

9. Portfolio spec has three parts: 
    - Feature selection
    - ranking based on features
    - weights on different instruments based on ranking

10. How is the backtesting done today?

11. When you do backtesting, how do you do compare with other portfolios? How many portfolios do you compare at a time?

12. How many real market constraints are put into the simulation today?
    - market partcipation constraints?
    - liquidity constraints?


- Goal is to create risk models (Very important)



## Notes

1. Fund Management
    - Decisions on day to day basis
    -  Actual and model portfolio
    - Daily cash comes in you have merge actual and model
    - Depending on the wrapper: PMS, AIF, MF

2. Signal Research
    - What signals will you use to build a model?
    - most reasearched
    - but 25% contribution

    eg: growth, factor research to understand what features to look at; earinigs revision is one factor 

3. Implementation researchh
    - real world constraints, max rank, 

7-8 secs for 17 year data for 1 simulation

## RiSK models
    - BARRA models, AXIOMA, BLOOMBERG
    - FAMA FRENCH


## What works on Wall Street


1. Pricing data, fudamental data

Requirement 
- Fund Accounting layer: What is the impact of expense ratio? What is the impact of taxes?
- tradebot
- Explainability (of suggestions or reasons for portfolio performance)


--------------
# 3 April

## Questions
1. How frequently would the features be computed? 

2. Are we correct in assuming that features are indicators like P/E ratios and so on.

3. Data is updated every 4 hours?

4. Suppose we have a UI, how do you envision the UI?
    - buttons, 
    - a custom way to write weighing functions?


----
1. Factset (18 years data);
    -  5-6 GB 
    - Everyday you pull some data

2. Data cleaning and preprocessing
    -  apply corporate actions
    - 