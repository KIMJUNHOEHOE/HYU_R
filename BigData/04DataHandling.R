# Lecture : DataHandling = Data Pre-processing
# Date : October 8th, 2018


# 예제 데이터 : ggplot2::diamonds
# ggplot 패키지 설치
install.packages("ggplot2")
install.packages("DT")
install.packages("dplyr")
install.packages("writexl")

library(ggplot2)
library(DT)
library(dplyr)
# dplyr::select, filter, mutate, arrange / dplyr의 pipe 기능
library(writexl)

# 작업공간
setwd("c:/R/BigData/")


# 1. 데이터 전체 보기 ----
# 1.1 data ----
# console에 출력
# 데이터가 적을 때 사용
diamonds

# 1.2 View(data) ----
# editor window에 출력됨
# 데이터가 많을 때 사용
View(diamonds)

# 1.3 DT::datatable(data) ----
# web 형태로 출력이 됨
DT::datatable(diamonds)


# 2. 데이터 일부 보기 ----
# 2.1 head(data, n=6) ----
# 위에서부터 일부 보기
head(diamonds)
head(diamonds, n=10)

# 2.2 tail(data, n=6) ----
# 아래서부터 일부 보기
tail(diamonds)
tail(diamonds, n=10)

# 2.3 View(head(data, n=6)) or View(tail(data,n=6)) ----
View(head(diamonds))
View(tail(diamonds))

# 2.4 DT::datatable(head(data, n=6))
DT::datatable(head(diamonds, n=6))


# 3. 데이터의 구조(structure) 보기
# str(data)
str(diamonds)


# 4. 데이터의 입력오류 체크하기 ----
# summary(data)
summary(diamonds)

id <- 1:5
address <- c("고양시","용산구","강서구","경주시")
dwell <- c(26,20,3,1,3)
home <- data.frame(id, address, dwell, stringsAsFactors = FALSE )
home
str(home)
summary(home)
home$address <- as.factor(home$address)
str(home)
summary(home)


# 5. 데이터의 속성 ----
# 5.1 행의 개수 : nrow(data) ----
# 리턴 형태 : vector
nrow(diamonds)

# 5.2 열의 개수 : ncol(data) ----
# 리턴 형태 : vector
ncol(diamonds)

# 5.3 행의 이름 : rownames(data) ----
# 리턴 형태 : vector
rownames(diamonds)
View(rownames(diamonds))

# 5.4 열 = 변수의 이름 : colnames(data) ----
# 리턴 형태 : vector
colnames(diamonds)

# 5.5 차원(dimension) : dim(data) ----
# 리턴 형태 : vector
dim(diamonds)
dim(diamonds)[1] # 행의 개수
dim(diamonds)[2] # 열의 개수

# 5.6 차원의 이름 : dimnames(data) ----
# 리턴 형태 : list
dimnames(diamonds)
dimnames(diamonds)[1] # 리턴값 list
dimnames(diamonds)[[1]] # 리턴값 vector


# 6. 데이터의 Slicing ----
# data[rowIndex, colIndex]

# 6.1 열 = 변수 ----
# data[ ,colIndex]
# (1) 열 = 변수의 위치를 알 때
diamonds[,1] # dataFrame의 리턴값은 dataFrame
diamonds[,2]

# 문제1
# 1,9,10번째 열을 한 번에 가져오세요.
diamonds[, c(1,9,10)]
# 문제2
# 4~8 번째 열을 한 번에 가져오세요.
diamonds[,4:8]
# 문제3
# 홀수 번째 열을 한 번에 가져오세요.
diamonds[ , seq(from=1, to= ncol(diamonds), by=2) ]

# (2) 열 = 변수의 이름을 알 때
diamonds[ , "carat"]
diamonds[ , "cut"]
diamonds[ , c("carat","cut")]
# 문제4
# x,y,z 라는 열을 한 번에 가져오세요.
diamonds[ , c("x","y","z")]

# (3) 열 = 변수 이름의 규칙(패턴)이 있을 때 - 정규식
# grep - general regular expression
# grep(pattern, textData, value = TRUE or FALSE)
colnames(diamonds)

# i. 변수명 중에서 t라는 글자를 포함하는 변수명은?
grep("t", colnames(diamonds), value = TRUE)  # 변수명 : 리턴값 벡터
grep("t", colnames(diamonds), value = FALSE) # 변수 인덱스 : 리턴값 벡터
diamonds[ ,grep("t", colnames(diamonds), value = TRUE)]
diamonds[ ,grep("t", colnames(diamonds), value = FALSE)]

# ii. 변수명 중에서 t라는 글자로 시작하는 변수명은? ^t
# table
grep("^t", colnames(diamonds), value = TRUE)  # 변수명 : 리턴값 벡터
grep("^t", colnames(diamonds), value = FALSE) # 변수 인덱스 : 리턴값 벡터
diamonds[ ,grep("^t", colnames(diamonds), value = TRUE)]
diamonds[ ,grep("^t", colnames(diamonds), value = FALSE)]

# iii. 변수명 중에서 t라는 글자로 끝나는 변수명은? t$
grep("t$", colnames(diamonds), value = TRUE)  # 변수명 : 리턴값 벡터
grep("t$", colnames(diamonds), value = FALSE) # 변수 인덱스 : 리턴값 벡터
diamonds[ ,grep("t$", colnames(diamonds), value = TRUE)]
diamonds[ ,grep("t$", colnames(diamonds), value = FALSE)]

# 정규식
# [0-9] : 모든 숫자
# "[a-Z]" : 모든 대소문자
# "[t|a]" : t 또는 a를 포함하는 변수
# "^[t|a]" : t 또는 a로 시작하는 변수
# "[t|a]$" : t 또는 a로 끝나는 변수

# (4) dplyr::select(data, variable1, variable2, ...), select는 컬럼 가져올 때
dplyr::select(diamonds, cut)
dplyr::select(diamonds, cut, color)
dplyr::select(diamonds, price:z) # price부터 z까지
dplyr::select(diamonds, -(price:z)) # price부터 z까지 빼고
dplyr::select(diamonds, starts_with("t"))
dplyr::select(diamonds, contains("t"))
dplyr::select(diamonds, ends_with("t"))

# 6.2 행 ----
# data[rowIndex,]

# (1) 행의 위치를 알 때
diamonds[1,]
diamonds[c(1,3),]
diamonds[4:8,]
diamonds[seq(from=1, to= nrow(diamonds), by=100),]

# (2) 조건을 만족하는 행
# i. cut이 "Ideal"인 데이터
diamonds[diamonds$cut == "Ideal"  , ]

# ii. price가 18000 이상인 데이터
diamonds[diamonds$price >=18000,]

# iii. cut은 "Ideal"이고, price는 18000 이상인 데이터
diamonds[(diamonds$cut == "Ideal")&(diamonds$price >=18000),]

# iv. cut은 "Ideal"이거나 또는 price는 18000이상인 데이터
diamonds[(diamonds$cut == "Ideal") | (diamonds$price >=18000),]

# 문제 5
# cut이 "Ideal"이거나 또는 "Good"인 데이터
diamonds[(diamonds$cut == "Ideal") | (diamonds$cut == "Good"), ]
diamonds[(diamonds$cut)==c("Ideal","Good"), ] # 틀림
diamonds[diamonds$cut %in% c("Ideal","Good"), ] # 서울이 30개 구라면 | 쓸 경우 매우 길어진다.

# (3) dply::filter(data, 조건), filter는 행 가져올 때
dplyr::filter(diamonds, cut=="Ideal")
dplyr::filter(diamonds, price>=18000)
dplyr::filter(diamonds, cut=="Ideal", price>=18000) # Ideal 이고 price가 18000이상인
dplyr::filter(diamonds, (cut=="Ideal") | (price>=18000))
dplyr::filter(diamonds, cut %in% c("Ideal", "Good") )


# 6.3 행과 열 ----
# (1) data[rowIndex, colIndex]
# cut이 "Ideal"이고, price는 18000이상인 데이터의 x,y,z라는 변수(열)을 가져오세요.
diamonds[(diamonds$cut == "Ideal") & (diamonds$price >=18000), c("x","y","z")]

# (2) dplyr::filter(), dplyr::select() / filter를 먼저 해야 함 where절 처럼
diamonds2 <- dplyr::filter(diamonds,cut =="Ideal", price>=18000)
dplyr::select(diamonds2, x:z)

# %>% : pipe, chain / diamonds2 만들지 않고 생성하기 ctrl + shift + m
# %>% 이전의 데이터를 다음 코드로 넘기기
diamonds %>% # 결과를 다음으로 넘겨줌
  dplyr::filter(cut=="Ideal" & price>=18000) %>% # 결과를 다음으로 넘겨줌
  dplyr::select(x:z) %>% 
  head()


# 7. 새로운 변수(열) 만들기 ----
# data$newVariable <- 작업

# 7.1 연산 ----
diamonds$xyzMean <- ((diamonds$x + diamonds$y + diamonds$z) /3)
diamonds$xyzMean2 <- rowMeans(diamonds[ ,c("x","y","z")])
diamonds$xyzMean3 <- rowMeans(dplyr::select(diamonds,x:z))
View(diamonds)
# rowSums(), colMeans(), colSums()

# 7.2 변환(Transformation) ----
# Box-Cox Transformation

# (1) log 변환
# ex) 비대칭 정보를 대칭 정보로 변환하고 싶을 때. 
# ex) 단위가 달라서 큰 영향을 미칠 때
diamonds$priceLog10 <- log10(diamonds$price) # vectorization for문인 것처럼

# (2) root 변환
diamonds$priceRoot <- sqrt(diamonds$price)

# (3) 역수 변환
diamonds$priceInverse <- 1 / diamonds$price

# 7.3 구간의 정보 ----

# (1) cut : 숫자형 구간일 때 
# data$newVariable <- cut(data$variable,
#                       breaks = 구간의 정보,
#                       right = TRUE or FALSE) : right 어디에 등호를 붙일 것인지
diamonds$priceGroup <- cut(diamonds$price,
                           breaks = c(0, 5000, 10000, 15000, 20000),
                           right = FALSE) # 이상~ 미만 구간

# cut() 함수를 사용하면 새로운 변수는 무조건 Factor가 됨
levels(diamonds$priceGroup)
levels(diamonds$priceGroup) <- c("5000미만", "5000이상~10000미만", "10000이상~15000미만","15000이상~20000미만")

table(diamonds$priceGroup)

# 문제6
# carat <- caratGroup
# 0 ~ 1.5 : 1.5미만
# 1.5~ 3.0 : 1.5이상 ~ 3.0 미만
# 3.0 ~ 4.5 : 3.0이상 ~ 4.5미만
# 4.5 ~ 6.0 : 4.5 이상
summary(diamonds)
diamonds$caratGroup <- cut(diamonds$carat,
                           breaks = c(0, 1.5, 3.0, 4.5, 6.0), # seq(from=0, to=6, by = 1.5)
                           right = FALSE)
levels(diamonds$caratGroup) <- c("1.5미만", "1.5이상 ~ 3.0 미만", "3.0 이상 ~ 4.5미만", "4.5이상")
levels(diamonds$caratGroup) 
table(diamonds$caratGroup)
View(diamonds$caratGroup)

# (2) ifelse() : 기본적으로는 두 집단 / ifelse()는 character vector 리턴
# i. 구간의 정보
# price -> priceGroup2
# 0~5000미만 : Cheap
# 5000이상 ~ 20000 : Non-Cheap
diamonds$priceGroup2 <- ifelse((diamonds$price >=0) & (diamonds$price < 5000),
                               "Cheap", "Non-Cheap")
summary(diamonds)

# ifelse로 세 집단으로 나누고 싶을 때는 중첩한다.
# price -> priceGroup3
# 0 ~ 5000미만 : Cheap
# 5000이상 ~ 15000 : Medium
# 15000이상 ~ 20000 : Expensive
diamonds$priceGroup3 <- ifelse(diamonds$price < 5000, 
                               "Cheap", 
                               ifelse(diamonds$price<15000, "Medium",
                                      "Expensive"))
table(diamonds$priceGroup3)

# ii. 다양한 범주를 축소할 때
# cut       -> cutGroup
# Fair      -> Non-Ideal
# Good      -> Non-Ideal
# Very Good -> Non-Ideal
# Premium   -> Non-Ideal
# Ideal     -> Ideal

# ifelse(조건, 조건이 참일 때 가지는 값, 조건이 거짓일 때 가지는 값)
diamonds$cutGroup <- ifelse(diamonds$cut == "Ideal", "Ideal", "Non-Ideal")
table(diamonds$cutGroup)

# 7.4 dplry::mutate(data, newVariable = 연산, 변환 등) ----
diamonds <- diamonds %>% 
  dplyr::mutate(caratLog=log10(carat))
View(diamonds)

diamonds <- diamonds %>% 
  dplyr::mutate(xyzSum = x + y + z)


# 8. 변수 삭제하기 ----
# 8.1 Slicing ----
# diamonds <- diamonds[ ,c("carat","cut","color")]

# 8.2 data$variable <- NULL
diamonds$cutGroup <- NULL
diamonds$priceGroup2 <- NULL
diamonds$priceGroup3 <- NULL

str(diamonds)


# 9. 외부 데이터로 저장하기(Export) ----
# 9.1 txt ----
# write.table(data,
#             file = "directory/filename.txt",
#             sep = ",",          데이터를 저장할 때 , 로 구분하기
#             row.names = FALSE, 행의 이름을 저장하지 않음
#             col.names = TRUE)  열의 이름을 저장함
getwd()
write.table(diamonds,
            file = "diamonds_1010.txt",
            sep = ",",
            row.names = FALSE,
            col.names = TRUE)

# facebook, blog

# 9.2 csv ----
# write.csv(data,
#           file = "directory/filename.csv,
#           row.names = FALSE,
#           col.names = TRUE)
write.csv(diamonds,
          file = "diamonds_1010.csv",
          row.names = FALSE,
          col.names = TRUE)

# 9.3 excel ----
# excel에 관한 기본 기능이 없다.
# writexl::wrtie_xlsx(data,
#                     path = "directory/filename.xlsx") default 값이 행 이름 저장 x
writexl::write_xlsx(diamonds,
                    path = "diamonds_1010.xlsx",
                    col_names = TRUE)

# 10. RData로 저장하기 ----
# 잠깐 어디 갔다올 때에도 data저장
# save(data,
#      file = "directory/filename.RData")
save(diamonds,
     file= "diamonds_1010.RData")

# 11. RData 불러오기 ----
# load(file = "directory/filename.RData")  파일을 불러와서 메모리 위에 올려놓음
load("diamonds_1010.RData")


# 12. Data의 목록보기 ----
# 사용자가 만든 데이터
# ls()
# ls : list segment의 약자
# ls() 의 결과는 character vector
ls()


# 13. 데이터 삭제하기 ----
# 13.1 하나 또는 몇 개의 데이터 삭제하기 ----
# 메모리상에 많은 데이터를 놓는 것은 좋지 않음
# rm(data1, data2)
rm(traffic,tab,survey)
ls()

# 13.2 모든 데이터 삭제하기 ----
# rm(list=ls())
rm(list=ls())
ls()


# 14. 데이터의 정렬 ----
# 14.1 벡터의 정렬 ----
# sort(vector, decreasing = FALSE or TRUE) default : decreasing = FALSE, 오름차순
feet <- c(265, 285, 240, 270, 265)
feet
sort(feet) # 원 데이터는 변하지 않음
feet <- sort(feet)
sort(feet, decreasing=TRUE) # 내림차순

# 14.2 Data.Frame의 정렬 ----
# order(data$variable, decreasing = FALSE) : default , 오름차순
# data[order(data$variable, decreasing = FALSE), ]
order(feet, decreasing = FALSE) 
# 리턴값은 원 데이터의 Index를 나타내는 vector, 같은 값은 앞 순서의 값이 먼저
order(feet, decreasing = TRUE)

feet[order(feet, decreasing = FALSE)] # sort(feet)의 값과 동일

# cut : 오름차순
diamonds[order(diamonds$cut, decreasing = FALSE ), ]
# cut : 내림차순
diamonds[order(diamonds$cut, decreasing = TRUE ), ]
# cut : 오름차순, price : 오름차순
# cut을 기준으로 먼저 오름차순으로 정렬하고, 그 내에서 price를 기준으로 오름차순 정렬
diamonds[order(diamonds$cut, diamonds$price, decreasing = FALSE) , ]

# cut : 내림차순, price : 내림차순
diamonds[order(diamonds$cut, diamonds$price, decreasing = TRUE), ]

# cut 오름차순, price : 내림차순
diamonds[order(diamonds$cut, -diamonds$price, decreasing = FALSE), ]
# - 는 숫자값에만 가능
# cut 내림차순, price : 오름차순
diamonds[order(diamonds$cut, -diamonds$price, decreasing = TRUE), ]

# cut : 오름차순, color : 내림차순
# 둘다 character일 경우, R의 기본 기능에서는 못함
# dplyr::arrange(data, variable, desc(variable))
dplyr::arrange(diamonds, cut, desc(color))
# %>% 기능 이용
diamonds %>% 
  dplyr::arrange(cut,desc(color))


# 문제 7
# xyz.mean이라는 새로운 변수를 만들고,
# 이 값을 기준으로 내림차순 정렬한 다음에,
# 상위 5개만 모이도록 하시오.
diamonds$xyz.mean <- (diamonds$x + diamonds$y + diamonds$z)/3
View(diamonds)
head(diamonds[order(diamonds$xyz.mean, decreasing = TRUE), ])

diamonds %>% 
  dplyr::mutate(xyz.mean=mean(c(diamonds$x,diamonds$y,diamonds$z))) %>% 
    dplyr::arrange(desc(xyz.mean)) %>% 
                   head(n=5)

diamonds %>% 
  dplyr::mutate(xyz.mean=rowMeans(dplyr::select(diamonds, x:z))) %>% 
  # dplyr::select(diamonds, x:z)) dataframe, rowMeans는 2차원 구조에서만 평균 가능
  dplyr::arrange(desc(xyz.mean)) %>% 
  head(n=5)

# 15. 데이터 합치기 ----
# 15.1 rbind(data1, data2) ----
# 데이터를 위/아래로 합침
# 데이터의 변수명, 변수의 위치가 동일해야 함
DF1 <- data.frame(id    = 1:3,
                  age   = c(10,20,30),
                  gener = c("F", "F", "M"))
DF2 <- data.frame(id    = 4:7,
                  age   = c(40,50,60,70),
                  gener = c("F", "M", "F", "M"))
DF1;DF2
DF3 <- rbind(DF1, DF2)
DF3

# 15.2 cbind(data1, data2) ----
# 데이터를 열로 합침
# 동일한 행이어야 함
DF4 <- data.frame(id = c("김준회", "이민수", "김경태"),
                  age = c(27, 26, 27),
                  bt = c("O", "B", "O"))
DF5 <- data.frame(address = c("부천시", "시흥시", "강남구"),
                  company = c("인사이트마이닝", "삼성전자", "삼성전자"))
DF6 <- cbind(DF4, DF5)
DF6

# 15.3 merge(data1, data2, by = "primarykey") ----
DF7 <- data.frame(id     = c(1,2,4,5),
                  age    = c(10,20,40,50),
                  gender = c("M","M","F","F"))

DF8 <- data.frame(id    = c(1,4,7,8,9),
                  money = c(1000,4000,7000,8000,9000),
                  food  = c("맥주","노트북","AUDI7","맥주","헬리콥터"))

DF7;DF8

# (1) inner join : 1,4
DF9 <- merge(DF7, DF8, by = "id") # primary가 2개 일 경우 c()
DF9

# (2) outer join : full join , id기준 합집합, 1,2,4,5,7,8,9
# merge(data1, data2, by = "primarykey", all = TRUE)
DF10 <- merge(DF7, DF8, by = "id", all = TRUE)
DF10

# (3) outer join : left join , id기준, 1,2,4,5
# merge(data1, data2, by = "primarykey", all.x = TRUE)
DF11 <- merge(DF7, DF8, by= "id", all.x = TRUE)
DF11

# (4) outer join : right join , id기준, 1,4,7,8,9
# merge(data1, data2, by = "primarykey", all.y = TRUE)
DF12 <- merge(DF7, DF8, by= "id", all.y = TRUE)
DF12
