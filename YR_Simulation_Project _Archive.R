# Install required packages if needed:
# install.packages(c("ggplot2", "gganimate", "transformr", "dplyr"))

library(ggplot2)
library(gganimate)
library(dplyr)

# 1. Generate simulation dataset
set.seed(42)
n_trials <- 12
stimuli <- c("Sad", "Happy", "Happy", "Sad", "Happy", "Happy",
             "Sad", "Happy", "Happy", "Sad", "Happy", "Happy")

df_healthy <- data.frame(
  Trial = 1:n_trials,
  Condition = "Healthy",
  Stimulus = stimuli,
  Sad_Load = c(1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0),
  Reaction_Time = rnorm(n_trials, mean = 470, sd = 20)
)

df_depressed <- data.frame(
  Trial = 1:n_trials,
  Condition = "Depressed",
  Stimulus = stimuli,
  Sad_Load = c(1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 6),
  Reaction_Time = rnorm(n_trials, mean = 740, sd = 40) + c(1:12)*15
)

df_sim <- rbind(df_healthy, df_depressed)

# 2. Build animated plot in R
p <- ggplot(df_sim, aes(x = Trial, y = Reaction_Time, color = Condition, group = Condition)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = c("Healthy" = "#0072B2", "Depressed" = "#D55E00")) +
  scale_x_continuous(breaks = 1:n_trials) +
  labs(
    title = 'Working Memory Break-Set Reaction Time (Trial {frame_along})',
    subtitle = 'Comparing Healthy vs. Depressed Updating Dynamics',
    x = 'Task Trial Sequence',
    y = 'Reaction Time (ms)'
  ) +
  theme_minimal(base_size = 14) +
  transition_reveal(Trial)

# 3. Render GIF
animate(p, width = 700, height = 400, fps = 10, renderer = gifski_renderer())



