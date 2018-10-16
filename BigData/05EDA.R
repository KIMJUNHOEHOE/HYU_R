# Lecture : EDA(Explorary Data Analysis), 탐색적 데이터 분석
# Date : October 10th, 2018

# 데이터에 숨겨진 패턴(pattern) 또는 특징을 찾아내는 작업
# 그래프와 표를 잘 그려야 함.

install.packages("ggplot2") # Visualization : 시각화
install.packages("dplyr")   # Data Analysis and Handling
install.packages("RColorBrewer") # Colors
install.packages("stringr") # 문자열 처리 패키지
install.packages("prettyR") # Mode(최빈값), 상관관계분석
install.packages("e1071") # Skewness, Kurtosis, SVM
install.packages("psych") # Descriptive Statistics = Summary Statistics

library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(stringr)
library(prettyR)
library(e1071)
library(psych)
library(writexl)

# 작업공간
setwd("c:/R/BigData/")


# 데이터 읽어오기
# ggplot2::diamonds


# 데이터의 종류(통계적인 관점)
# 1. 질적 자료 = 범주형 자료 : 글자(문자) = character vector or factor, numeric vector
# 2. 양적 자료 : numeric vector 
# 질적 자료의 numeric vector와 양적 자료의 numeric vector를 나누는 기준 : 사칙연산 계산

# diamonds
diamonds <- diamonds[ ,1:10] # 원 데이터로 복구
# 질적 자료 : cut, color, clarity
# 양적 자료 : carat, depth, table, price, x, y, z

# 1. 일변량(Uni-variate) 질적 자료의 분석 ----
# 1.1 표 ----
# (1) 빈도(Frequency)
# table(data$variable) - 리턴 값은 vector
table(diamonds$cut)
sort(table(diamonds$cut), decreasing = TRUE)
sort(table(diamonds$cut), decreasing = TRUE)[1:3]

table(diamonds$color)
table(diamonds$clarity)

# matrix의 슬라이싱은 한 개 열일 경우, drop = FALSE 일 경우 매트릭스 형태
# data.frame의 슬라이싱은 리턴 형태는 data.frame
diamonds[,2] # cut 
class(diamonds[,2])
diamonds[,3] # color
diamonds[,4] # clarity

for(i in 2:4){ # for문 실행할 때 커서의 위치는 for에
  print(sort(table(diamonds[ , i]), decreasing = TRUE))
}

# (2) 백분율(Percent)
# prop.table(frequency) : 비율 : 0~1 , property
# prop.table(frequency)*100 : 백분율
prop.table(table(diamonds$cut))*100 # 리턴값은 vector
sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE)
# 백분율 소수점 자리수는 특별하지 않으면 한 자리 표현함
# round( , digits=1) : 소수점 두 번째에서 반올림해서 첫 번째 까지 보여줌
round(sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE) , digits = 1)

# 문제1
# for를 이용해서 세 개의 질적 자료에 대한
# 빈도, 백분율을 출력하시오.
for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ ,i]))*100,decreasing = TRUE), digits=1))
}

for(i in c("cut","color","clarity")){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ ,i]))*100,decreasing = TRUE), digits=1))
}

# 특정 패턴이 있는 열 찾기 -> grep 쓰기

# 1.2 그래프 ----
# (1) 막대 그래프 : 세로/가로 ----
# barplot(frequency or percent)
barplot(sort(table(diamonds$cut),decreasing = TRUE))
barplot(prop.table(sort(table(diamonds$cut),decreasing = TRUE))*100)

# i. 막대 색깔 : col = "color"
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = "tan4")

# 문제 2
# 막대 색깔을 다 다르게 하시오.
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = c("tan4","red","blue","springgreen","white"))

pal <- RColorBrewer::brewer.pal(n = 5, name = "BuGn")
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = pal)
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = rainbow(5))

# ii. 차트의 제목 : main = "title"
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds")

# iii. y축 제목 : ylab = "y axis's label"
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds",
        ylab = "frequency",
        xlab = "degree")
# iv. y축 눈금 : ylim = c(min,max)
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds",
        ylab = "frequency",
        xlab = "degree",
        ylim = c(0,25000)
        )

# v. 가로 막대그래프 : horiz = TRUE
barplot(sort(table(diamonds$cut), decreasing = FALSE), 
        col = "tan4",
        main = "Cut of Diamonds",
        xlab = "frequency",
        ylab = "degree",
        xlim = c(0,25000),
        horiz = TRUE
        )

# 문제3
# for를 이용해서 세 개의 질적 자료에 대한 각각의 막대 그래프를 작성해보세요.
for(i in c("cut","color","clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(i,"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
          )
}

for(i in 2:4){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
}

# paste(character1, character2, ..., sep =" " )
# 규칙 있는 변수 만들 때도 유용
stringr::str_to_title(paste("i", "am", "boy", sep=":"))
paste("Love","is","choice.")
paste("Love","is","choice.", sep = "-")
paste("Love","is","choice.", sep = "")
paste("나는", c("준회", "도균", "세호"), sep = "-")
paste("V", 1:10, sep = "") # vectorization, recycling rule
paste("cut", "of Diamonds")
paste("color", "of Diamonds")
paste("clariy", "of Diamonds")
colnames(diamonds)
colnames(diamonds)[2]
colnames(diamonds)[3]
colnames(diamonds)[4]

tolower("Love is choice.") # 소문자
toupper("Love is choice.") # 대문자

stringr::str_to_title("i am a boy") # 첫 시작(공백단위) 문자를 대문자


# (2) 원 그래프 ----
# pie(freqency or percent)
pie(sort(table(diamonds$cut), decreasing = TRUE))
pie(prop.table(sort(table(diamonds$cut), decreasing = TRUE)),
    col = pal)

# i. 반지름의 크기 : radius = 0.8 : default
pie(sort(table(diamonds$cut
               ), decreasing = TRUE),
    col = pal,
    radius = 1)

# ii. 시계 방향 : clockwise = TRUE : default - FALSE
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal,
    radius = 1,
    clockwise = TRUE)

# iii. 첫째 조각의 시작 각도 : init.angle =
# 시계 반대 방향 : 0, 0도 기준이 3시방향
# 시계방향 : 90
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal,
    radius = 1,
    clockwise = TRUE,
    init.angle = 270)

# 문제4
# 질적 자료 세 개에 대한 각각의 막대/원 그래프를 작성하시오.
# (단, 제목도 나오도록)
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
          )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
      )
  
}

# 그래프 화면 분할하기
# par(mfrow = c(nrow, ncol)) : 행부터 채워짐
# par(mfcol = c(nrow, ncol)) : 열부터 채워짐
# par : partition, mf : multi frame

par(mfrow = c(3,2)) # 이제부터 그래프 만들면 순서대로 들어감.
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}

# 그래프 화면 원상태 복구
# par(mfrow = c(1,1))
par(mfrow = c(1,1))

# 그래프를 pdf 파일로 저장하기
# pdf(file = "directory/filename.pdf") : 저장 시작
# 그래프 작업
# dev.off() : 저장 끝
# graphic device off의 약자
pdf(file = "output1.pdf")
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}
dev.off()

# pdf 한 페이지에 여러 개의 그래프 저장하기
pdf(file = "output2.pdf")
par(mfrow = c(3,2))
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}
dev.off()
par(mfrow=c(1,1))


# ggplot2 패키지를 이용해서 그래프 작성하기 ----
# ggplot2::ggplot(data = , mapping = aes(x = variable)) +
# geom_bar() , 막대그래프
# 알아서 빈도를 구해서 막대 그래프를 구해줌
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + # fill : 색상 채워줌
  geom_bar() + # 막대 그래프
  theme_classic() + # ggplot 배경 꾸미기
  facet_wrap(~ color + clarity) # color, clarity별 막대 그래프

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + 
  geom_bar() +
  labs(title = "Cut of Diamonds",
       x = "Cut",
       y = "Frequency")

# 2. 일변량 양적 자료의 분석 ----

# 2.1 표 = 빈도표 ----
# (1) 구간의 빈도
# 구간 만들기
# i. 최소값, 최대값
min(diamonds$price)
max(diamonds$price)
# ii. 범위 = 최대값 - 최소값
priceRange <- max(diamonds$price)-min(diamonds$price)
# iii. 구간의 개수 : Sturges Formular : 1 + 3.3*log(n)
intervalCount <- 1 + 3.3*log10(length(diamonds$price))
# iv. 구간의 폭 = 계급의 폭 = 범위/구간의 개수
intervalWidth <- priceRange/17
# v. 첫 구간: 최소값/ 마지막 구간 : 최대값이 되도록 조정

diamonds$priceGroup <- cut(diamonds$price, # cut은 자동적으로 factor
                           breaks = seq(from =0, to= 19000, by = 1000),
                           right = FALSE)
table(diamonds$priceGroup) # cut은 리턴값이 factor이기 때문에 table 사용하면 구간의 빈도 구함
sort(table(diamonds$priceGroup), decreasing = TRUE)

# (2) 구간의 백분율 - prop.table(freqeuncy) * 100
round(sort(prop.table(table(diamonds$priceGroup))*100, decreasing = TRUE), digits = 1)

# 2.2 그래프 ----
# (1) 히스토그램
# hist(data&variable, breaks = ) 
hist(diamonds$price, # defalut : Sturges Formular가 적용됨
     xlim = c(0,20000)
     )
?hist
histResult <- hist(diamonds$price)
histResult
histResult$counts # 리턴값 벡터
str(histResult)

# List의 Slicing
# (1) list[index]
# (2) list[[index]]
# (3) list$index

hist(diamonds$price,
     breaks = seq(from=0, to=20000, by=2000))

hist(diamonds$price, breaks = 200) # 구간의 개수

# (2) 상자 그림(Boxplot)
# boxplot(data$variable, range = 1.5)
boxplot(diamonds$price, range = 1.5) # range = 1 : 2시그마 이상을 이상치로 보겠다.
# IQR = Q3(3분위수)-Q1(1분위수)
# Q3 + 1.5IQR 이상의 값들은 이상치라고 함 # range = 1.5 : 3 시그마 이상을 이상치로 보겠다.
# Q1 - 1.5IQR 아래의 값들도 이상치
boxplot(diamonds$price, range = 1)
boxplot(diamonds$price, range = 2)

# 집단별 상자그림
# boxplot(data$variable ~ data$variable)
# boxplot(양적 자료 ~ 질적 자료)
boxplot(diamonds$price ~ diamonds$cut) # cut 집단별 price boxplot 
# Ideal의 중위수 값이 가격이 낮은 이유 : carat이라는 변수의 기준이 같지 않기 때문에

# (3) ggplot2 패키지를 이용한 히스토그램/상자그림
# i. 히스토그램
ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram()

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) # bindwidth : 구간

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) +
  facet_wrap(~cut) # cut별로 히스토그램, 물결은 집단을 의미함

# ii. 상자그림
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, y=price)) +
  geom_boxplot()

# 2.3 기술통계량 = 요약통계량 ----

# (1) 중심 = 대표값 ----
# i. 평균(Mean) - 1,2,8,9 평균:5. 5는 1,2,8,9을 잘 대표할까? 그렇지는 않다. 차이가 많다
# 이상치가 많으면 평균이 대표값을 잘 나타내는 것은 아니다.
# mean(data$variable, na.rm = TRUE)
mean(diamonds$price, na.rm = TRUE)

# ii. 절사평균(Trimmed Mean) - 이상치가 많을 경우(상위5%, 하위5% 절삭)
# 평균 200 , 절사평균 20 : 데이터에 이상치가 있다. 큰 쪽에 이상치가 있다.
# 우리가 보지 못하는 데이터는 20에 가까운 수로 이루어져 있다.
# mean(data$variable, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.1 , na.rm = TRUE)

# iii. 중앙값(Median)
# 중앙값이 5가 나왔다. 그렇다면 자료는 어떻게 이루어져 있을까? 5와 비슷하겠다?
# 1,2,8,9
# 1,2,8,90
# 1,2,8,989 값이었다. 중앙값 5는 대표값으로 역할을 못 한다.
# 중앙값은 이상치의 영향을 평균보다 덜 받는다.
# 평균과 중앙값 사이에 차이가 크면 이상치가 있다.
# median(data$variable, na.rm = TRUE)
median(diamonds$price) # 절사평균과 비교해보면 여전히 이상치가 존재하는구나.

# iv. 최빈수(빈도가 가장 높은 값)
# 최빈수는 두 개 이상의 값이 될 수 있음
# 최빈수가 되기 위해서는 2번 이상 존재해야 함
# which.max(table(data$variable))
# prettyR::Mode(data$variable)
lunchFee <- c(5000,3500,5000,5000,3300)
which.max(table(lunchFee)) # which는 가장 큰 값이 있는 index를 돌려줌
which.max(table(diamonds$price)) # table(diamonds$price)에서 261번째에 있는 605가 최빈수
sort(table(diamonds$price), decreasing = TRUE)[1] # 최빈수는 605이고 그 빈도는 132개

prettyR::Mode(diamonds$price)

# (2) 퍼짐 = 산포도 ----
# 관심 있는 집단에 다름이 얼마나 존재할까를 수치화한 값
# 다름을 유발하게 한 원인을 찾는 것이 중요.

# i. 범위(Range) : 최대값 - 최소값
# diff(range(data$variable))
range(diamonds$price) # 벡터값 리턴, 최소값 최대값 2개를 리턴
diff(range(diamonds$price))
diff(c(326,18823,326)) # diff(c(a,b,c)) = b-a, c-b
# 범위는 이상치의 영향을 너무 많이 받음 => IQR = 사분위 범위(Q3-Q1)

# ii. 사분위범위(IQR : Inter Quartile Range)
# IQR(data$variable)
IQR(diamonds$price) # 데이터 간의 차이가 4400정도 보이고 있다.
# 사분위 범위수의 한계 : 데이터를 2개만 사용한다.

# iii. 분산(variance)
# R에서 구하는 평균과 분산은 , 표본평균 표본분산이다.
# var() : 표본분산
# R에서 모분산을 구하기 위해서는 (var()/(n-1))*n
# 편차 제곱의 평균
# 이상치의 영향을 받는다.
# 단위문제 때문에 표준편차 쓴다.
# 자유도 : 내가 실질적으로 컨트롤 할 수 있는 변수의 개수
# var(data$variable, na.rm = TRUE)
var(diamonds$price) # 분산의 단위는 달러의 제곱.

# iv. 표본의 표준편차(SD)
sd(diamonds$price)

# v. 중위수 절대 편차(MAD : Median Absolute Deviation)
# mad(data$variable)
# 평균과 분산은 이상치에 영향을 많이 받을 수 있으므로, 데이터를 확인하고 이상치가 존재할 경우
# 다름을 확인할 때에는 중위수 절대 편차 이용할 수 있다.
mad(diamonds$price) # 표준편차 4000과 비교할 때 다름에 대한 차이가 난다.

# (3) 분포의 모양
# i. 왜도(Skewness) : 대칭여부
# e1071::skewness(data$variable)
# 왜도 = 0 : 대칭
# 왜도 > 0 : 왼쪽으로 치우침 - 큰 이상치가 많을 경우
# 왜도 < 0 : 오른쪽으로 치우침 - 작은 이상치가 많을 경우
e1071::skewness(diamonds$price)
hist(diamonds$price)

# ii. 첨도(Kurtosis) : 중심(평균이지만 최빈값으로 이해)이 얼마나 뾰족한가(중심에 얼마나 몰려 있는가)
# 분산 : 전체적으로 평균에서 얼마나 퍼져있는가(수평)
# 첨도 : 중심에서 높이가 얼마인가(수직)(분산은 작아도 높이는 낮을 수 있음)
# 분산과 첨도는 다른 개념
# e1071::kurtosis(data$variable)
# 첨도 = 0 : 보통
# 첨도 > 0 : 뾰족, 높음
# 첨도 < 0 : 낮음.
# 통신회사에서는 첨도가 중요함. 전화가 몰리는 때
e1071::kurtosis(diamonds$price)

# (4) 기타
# i. 최소값 : min(data$variable)
# ii. 최대값 : max(data$variable)

# (5) 기술통계량(양적 자료)을 구하는 데에 유용한 함수들
# i. summary(data$variable) or summary(data)
summary(diamonds$price)
# 이 결과 중에서 평균만 빼면 Five Numbers Summary
# 해당 데이터에서는 평균이 자료의 대표값으로 적절하지 않음

summary(dplyr::select(diamonds, -(2:4), -priceGroup)) # 양적인 자료만 보고싶을 때

# ii. by(data$variable, data$variable, fuctionName)
#     by(양적자료, 질적자료, 함수명) : 질적자료 별로 양적 자료 함수처리
# 집단별로 함수처리 하고 싶을 때 사용!
by(diamonds$price, diamonds$cut, mean)
by(diamonds$price, diamonds$cut, mean, trim = 0.05) # cut 레벨 별 절사평균
by(diamonds$price, diamonds$cut, sd)
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, hist)
par(mfrow=c(3,2))
by(diamonds$price, diamonds$cut, hist, col ="blue")
par(mfrow =c(1,1))


# iii. psych::describe(), describeBy() - 10개 이상의 기술통계량(양적 자료)을 한 꺼번에 처리해줌
# psych::describe(data$variable)
# psych::describe(data)
psych::describe(diamonds$price) # default : trimmed는 10% 절사평균
psych::describe(diamonds$price, trim = 0.05)
psych::describe(dplyr::select(diamonds, -(2:4), -priceGroup))
# psych::describeBy(data$variable, data$variable) - By는 집단별로 처리할 때
# psych::describeBy(data, data$variable) - By는 집단별로 처리할 때
psych::describeBy(diamonds$price, diamonds$cut)
psych::describeBy(dplyr::select(diamonds, -(2:4), -priceGroup), diamonds$cut)

priceByCut <- psych::describeBy(diamonds$price, diamonds$cut)
mode(priceByCut)
priceByCut[[1]]

writexl::write_xlsx(priceByCut[[1]],
                    path="priceByCut_1011.xlsx",
                    col_names = TRUE)

# iv. dplyr::summarize(data, variableName = function(variable))
dplyr::summarise(diamonds, 
                 n = n(),
                 Mean = mean(price),
                 SD = sd(price))

# 집단별 : dplyr::group_by(data, variable)
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                   n = n(),
                   Mean = mean(price),
                   SD = sd(price))

# Mean을 기준으로 내림차순 정렬하기
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                  n = n(),
                  Mean = mean(price),
                  SD = sd(price)) %>% 
  dplyr::arrange(desc(Mean))

# 이 결과를 막대그래프로 그리기
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                    n = n(),
                    Mean = mean(price),
                    SD = sd(price)) %>% 
  dplyr::arrange(desc(Mean)) %>% 
  ggplot2::ggplot(mapping=aes(x=cut, y=Mean)) +
  geom_bar(stat = "identity") # 원 데이터를 가지고 할 때는 stat 안 쓰지만, 우리가 만든 기술통계량


# 문제
# cut은 "Good" 또는 "Very Good"이고,
# carat은 2 이상인 diamonds의
# xyz.sum을 구하고,
# cut별로 xyz.sum에 대한 히스토그램을 작성하시오.
diamonds %>% 
  dplyr::filter(cut %in% c("Good","Very Good"), carat >= 2) %>% 
  dplyr::mutate(xyz.sum=(x + y + z)) %>% 
  ggplot2::ggplot(mapping = aes(x = xyz.sum)) +
  geom_histogram() +
  facet_wrap(~cut)

# 문제
# ggplot2에서 제공하는 diamonds 데이터를 이용하고, carat이 2이하이고, cut이 "Ideal" 인
# 다이아몬드에 대해서 xyz.sum을 구하고, color별로 xyz.sum에 대한 평균 Mean을 구하고, Mean을 기준으로
# 오름차순으로 정렬하고, 이 자료를 이용하여 ggplot2 패키지를 사용하여 막대그래프를 작성하는 프로그램
diamonds %>% 
  dplyr::filter(carat<=2, cut =="Ideal") %>% 
  dplyr::mutate(xyz.sum=(x+y+z)) %>% 
  dplyr::group_by(color) %>% 
  dplyr::summarise(Mean = mean(xyz.sum)) %>% 
  dplyr::arrange(Mean) %>% 
  ggplot2::ggplot(mapping=aes(x=color, y=Mean)) +
  geom_bar(stat="identity")

# RStudio Cheatsheets : 패키지 기능들 한 번에 볼 수 있음
# KRUG : 페이스북 그룹 : R에 관해서 질문하고 싶을 때
# R Conference Korea : R 분석가
# 데이터야놀자(conference): R 엔지니어
# Kaggle
# RMarkdown