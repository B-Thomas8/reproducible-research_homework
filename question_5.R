#load data
virus_data <- read.csv("Cui_etal2014.csv")

#calculate number of rows and columns in table
ncol(virus_data)
nrow(virus_data)

#plot genome length against virion volume
ggplot(aes(Genome.length..kb., Virion.volume..nm.nm.nm.), data = virus_data) +
  geom_point()

#investigate distributions of virion volume and genome length
ggplot(aes(Virion.volume..nm.nm.nm.), data = virus_data) +
  geom_histogram()
ggplot(aes(virus_data$Genome.length..kb.), data = virus_data) +
  geom_histogram()
skewness(virus_data$Virion.volume..nm.nm.nm.)
skewness(virus_data$Genome.length..kb.)

#make linear model using this raw data to investigate residuals
lm_model <- lm(Genome.length..kb. ~ Virion.volume..nm.nm.nm., data = virus_data)
summary(lm_model)
plot(lm_model)


#the distribution of both variables is right-skewed, so log transform data
log_vol <- log(virus_data$Virion.volume..nm.nm.nm.)
log_length <- log(virus_data$Genome.length..kb.)
transformed_data <- data.frame(log_vol, log_length)
ggplot(aes(log_vol, log_length), data = transformed_data) +
  geom_point()


#make linear model of log-transformed data to work out exponent and scaling factor
lm_log <- lm(log_vol~log_length, data = transformed_data)
plot(lm_log)
summary(lm_log)


#reproduce figure
ggplot(aes(log_length, log_vol), data = transformed_data) +
  geom_point()+
  xlab("log[Genome length (kb)]") +
  ylab("log[Virion volume(nm3)]") +
  theme_minimal() +
  geom_smooth(method = "lm") +
  theme(axis.title = element_text(face="bold"), 
  panel.border = element_rect(colour = "black", fill=NA, linewidth=0.5))

#save packages
sink(file = "package-versions-Q5.txt")
sessionInfo()
sink()


