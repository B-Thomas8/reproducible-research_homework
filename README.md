# Reproducible research: version control and R

**Questions 1-3**: Answers found at: https://github.com/RT751/logistic_growth/tree/main

**Question 4**:

***A script for simulating a random walk is provided in the question-4-code folder of this repo. Execute the code to produce the paths of two random walks. What do you observe?***

When applied for 500 steps, the random walk function produces a two-dimensional path which starts at the coordinates at (0,0) and then proceeds in a series of 500 randomly directed steps. The path is shaded to show its progression over the 500 steps. Although the same function and number of steps (500) are used to make the first and second paths, they are completely different. They both start at (0,0) but have different trajectories and endpoints. The paths appear to have no directional tendency and often cross back over themselves. They have a jagged shape, where the paths appear to move in a new, random direction after every step. Also, if the code is run again, it produces two completely new paths. This shows how the function is producing a new, random path of 500 steps every time it’s run. 

***Investigate the term random seeds. What is a random seed and how does it work?***

Pseudorandom number generators produce random numbers by performing an operation on the previous value, meaning an initial value is needed to start the sequence. The term 'random seeds' refers to these initial values. Usually, the system's current time is used as a random seed, but it can be customised. The reason the number generators are ‘pseudorandom’ is because they are determined by the seed. Therefore, if the same seed is used, the same sequence of ‘random’ numbers will be produced. This means simulations can be made reproducible by setting the seed as a given number.  

***Show the edit you made to the code in the comparison view.***

The edit made to the code is shown below in the red square.
<p align="center">
     <img src="https://github.com/RT751/reproducible-research_homework/blob/main/edited_code.png" width="900" height="500">
  </p>


**Question 5**

***Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the question-5-data folder). How many rows and columns does the table have?***

The table has 33 rows and 13 columns. 

***What transformation can you use to fit a linear model to the data? Apply the transformation.***

When plotted, the raw data do not appear to have a linear relationship, and the distributions of both variables are skewed to the right. In addition, when a linear model is produced with the raw data, the residuals vs fitted values plot shows that the residuals are not evenly distributed. A log transformation of both variables can be used to resolve this and fit a linear model to the data. When plotted, the log-transformed data appear to fit a linear relationship much better. Moreover, the linear model produced using log-transformed data has more evenly distributed residuals. 

***Find the exponent (β) and scaling factor (α) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in Table 2 of the paper, did you find the same values?***

The allometric relationship between virion volume and genome length is described by the equation $`V = \alpha L^{\beta}`$, where V is virion volume ($nm^{3}$), L is genome length (kb), $\alpha$ is the scaling factor, and $\beta$ is the exponent. This can be transformed into a linear equation by taking the natural logarithm of both sides, resulting in the equation: $lnV = ln\alpha + \beta lnL$. The linear model produced using the log-transformed data corresponds to this equation. So, in the summary of the linear model of the log-transformed data, the intercept is $ln\alpha$  and the slope (log_length estimate) is $\beta$. According to the output of my model, the exponent ($\beta$) is 1.5152 and the slope ($ln\alpha$) is 7.0748. The scaling factor ($\alpha$) can be obtained by taking the exponential function of the slope estimate ($exp(7.0748)$ = 1181.807116). These values are the same as the results found in the paper (reported as 1.52 and 1182). The p-values from the model are $2.28 * 10^{-10}$ for the intercept estimate and $6.44*10^{-10}$ for the slope estimate. These are much smaller than 0.01, suggesting the results are statistically significant. 

***Write the code to reproduce the figure shown below.***

```
#load data
virus_data <- read.csv("Cui_etal2014.csv")

#transform data and make linear model
log_vol <- log(virus_data$Virion.volume..nm.nm.nm.)
log_length <- log(virus_data$Genome.length..kb.)
transformed_data <- data.frame(log_vol, log_length)
lm_log <- lm(log_vol~log_length, data = transformed_data)

#plot graph
ggplot(aes(log_length, log_vol), data = transformed_data) +
  geom_point()+
  xlab("log[Genome length (kb)]") +
  ylab("log[Virion volume(nm3)]") +
  theme_bw() +
  geom_smooth(method = "lm") +
  theme(axis.title = element_text(face="bold"))
```

***What is the estimated volume of a 300 kb dsDNA virus?***

$V = \alpha  L^{\beta}$

$\alpha = 1181.807116$

$L = 300$

$\beta = 1.5152$

$V = (1181.807116)(300)^{1.5152}$

$V = 6697006.583$ kb



## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers (also make sure that your username has been anonymised). All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \
   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \
   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\
   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \
   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 
