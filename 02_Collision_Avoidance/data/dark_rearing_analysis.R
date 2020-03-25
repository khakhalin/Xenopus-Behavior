
# Dark-rearing analysis

require(dplyr)
require(tidyr)
require(ggplot2)

# --- Escape probability
d <- read.csv('./_Science/Xenopus-Behavior-git/02_Collision_Avoidance/data/dark_rearing_successes.csv')
d <- d %>% mutate(Successes = escapes/n) 
d <- d %>% rename(Group=group)
names(d)

ds <- d %>% group_by(Group) %>% summarize(m=mean(Successes), s=sd(Successes))

ggplot(data=d,aes(Group,Successes,color=Group)) + theme_classic() + 
  geom_dotplot(binaxis="y", stackdir="center", binwidth=0.02, dotsize=2, fill=NA) +
  geom_point(data=ds, aes(Group,m))

# --- Escape geometry
d <- read.csv('./_Science/Xenopus-Behavior-git/02_Collision_Avoidance/data/dark_rearing_geometry.csv')
names(d)
ggplot(data=d,aes(SpeedBefore,SpeedAfter,color=Treatment)) + theme_classic() +
  geom_point(alpha=0.5)
ggplot(data=d,aes(abs(TurnAngle),abs(EscapeAngle),color=Treatment)) + theme_classic() +
  geom_point(alpha=0.5)

ggplot(data=d,aes(Treatment,abs(TurnAngle),color=Treatment)) + theme_classic() + 
  geom_dotplot(binaxis="y", stackdir="center", binwidth=2, dotsize=2, fill=NA) +
  stat_summary(shape=3, color='black') +
  ylim(0, 180) + scale_y_continuous(breaks = seq(0, 180, len = 5))
