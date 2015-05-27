library("rvest")

if (file.exists("dataLiverpool.csv")) {
	r1 <- read.csv("dataLiverpool.csv")
} else {
	urlIDs = c(115:123)
	for (i in 1:length(urlIDs)) {
		url <- paste0("http://www.lfchistory.net/SeasonArchive/Games/",urlIDs[i])
		results <- url %>%
			html() %>%
			html_nodes(xpath='//*[@id="ctl00_ctl00_ContentPlaceHolder1_ContentArea_ListGames_ctl00"]') %>%
			html_table()
		# Add season marker column
		results[[1]][, "Season"] <- substr(results[[1]][1,"Date"],7,10)
		# Merge
		if (i==1) {
			r1 <- results[[1]]
		} else {
			r1 <- rbind(r1,results[[1]])
		}
	}
	write.csv(r1,file="dataLiverpool.csv",row.names=FALSE)
}

# Flatten into 1 lovely table