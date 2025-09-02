library(dplyr)
library(wk)

# Check the dplyr package
x <- read.csv("in/mtcars.csv") |> dplyr::select(cyl)
write.csv(x, "out/cyl.csv")

# Check package paths
dplyr_path <- find.package("dplyr")
wk_path <- find.package("wk")
print(dplyr_path)
print(wk_path)

writeLines(c(dplyr_path, wk_path), "out/paths.txt")
