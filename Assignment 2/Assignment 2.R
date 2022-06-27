library (tidyverse)
library (janitor)
library(dplyr)

recycling_data<-read_csv("Recycling_Diversion_and_Capture_Rates.csv")
recycling_clean_names<-clean_names(recycling_data)
#renaming long columns names to make them easier to work with
recycling_rename<-rename(recycling_clean_names, diversion_rate_total=diversion_rate_total_total_recycling_total_waste, capture_rate_paper=capture_rate_paper_total_paper_max_paper, capture_rate_MGP=capture_rate_mgp_total_mgp_max_mgp, capture_rate_total=capture_rate_total_total_recycling_leaves_recycling_max_paper_max_mgp_x100, month=month_name)

#if wanted to just work with the totals
recycling_select<-select(recycling_rename, zone, district,fiscal_year, month, diversion_rate_total,capture_rate_total)

#if just wanted to work with most recent data
recycling_filtered<-filter(recycling_select, fiscal_year==2019)

#not the most helpful column, but example of mutate if wanted to compare columns. Seeing relationship bw capture and diversion numbers
recycling_mutate<-mutate(recycling_filtered, capture_dispersion_ratio= capture_rate_total/diversion_rate_total)

recycling_aggregated<-group_by(recycling_mutate, district)%>%
  summarise(capture_rate_total)

write_csv(recycling_mutate, "Assignment 2.csv")
write_csv(recycling_aggregated, "Assignment 2 aggregated.csv")