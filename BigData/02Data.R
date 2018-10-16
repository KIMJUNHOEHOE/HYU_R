# Lecture : Data
# Date    : October 5th, 2018

# 1. Vector **
# 2. Factor *
# 3. Matrix
# 4. Array
# 5. Data.Frame **
# 6. List *
# 7. Tibble
# 8. Data.Table
# 9. Time Series

# 1. Vector ----
# 하나의 열(column)로 인식
# 하나의 데이터 유형만 가짐
# 데이터 분석의 가장 기본 단위

# 1.1 Vector 만들기 ----
# (1) 하나의 값(element)으로 이루어진 Vector
v1 <- 10
v2 <- "buillee"
v3 <- TRUE

# (2) 두 개 이상의 값으로 이루어진 Vector
# i. c(elm, elm, ...)
# c : combine, concatenate의 약자
# element들 간의 규칙이 없을 때
age <- c(26,30,32)
food <- c("파스타","스테이크","샌드위치")
marry <- c(TRUE, FALSE, TRUE)

age2 <- c(27,34,27)
age3 <- c(age, age2)
age3
# 타입 우선순위에 따라 데이터가 변환됨
c(10,"Lee", FALSE) 
c(10,FALSE)

# ii. :
# numeric vector에만 적용됨
# start:end
# 1씩 증가되거나 또는 1씩 감소되는 값으로 이루어진 vector
# start < end : 1씩 증가
# start > end : 1씩 감소
1.2:2.3 # 1.2 , 2.2
1:5
1:100
5:1

# 문제
# -2.3:1 의 결과는? -2.3 , -1.3 , -0.3, 0.7

# 문제2
# 1:-2.3 의 결과는 ? 1, 0, -1, -2

# iii. seq(from = arg1, to = arg2, by= arg3)
# numeric vector에만 적용됨
seq(from=1,to=20, by= 0.5)
seq(from=1,to=20, length.out = 10) # 1부터 20까지 균일하게 10개로 
seq(from=5, to=1, by = -0.5)

# iv. sequence(number)
# numeric vector에만 적용됨
# 1 ~ number 사이의 정수로 이루어진 vector
# number가 음수가 되면 error
sequence(5)
sequence(3.7)
sequence(0.5)
sequence(0)
# 문제 4
# 1, 1,2, 1,2,3, 1,2,3,4, 1,2,3,4,5, 1,2,3,4,5,6 으로 이루어진 vector
c(sequence(1),sequence(2),sequence(3),sequence(4),sequence(5),sequence(6))
c(1,1:2,1:3,1:4,1:5,1:6)
sequence(1:6)
sequence(c(1,2,3,4,6))
# v. rep(vector, times=, each = )
# numeric, character, logical vector를 만들 수 있음
# replicate의 약자
# rep 함수 안에 지정된 vector를 times 또는 each 방식으로 복사해서
# vecotr를 만듬
rep(1, times= 10)
rep(1, each = 10)
rep(c(1,2), times = 10)
rep(c(1,2), each=5)

# 문제 5
# "A","B","c","A","B","c","A","B","c","A","B","c" 를 가지는 vector
rep(c("A","B","c"), times =4)

rep(1:3, times=3, each=2) # each가 먼저 작동

# 문제 6
# 1 : 100개, 2 : 53개, 3:13개로 이루어진 vector
c(rep(1, times=100), rep(2, times=53), rep(3, times=13))
rep(1:3, times = c(100,53,13))
rep(c(1,4,5), times=c(1,2,3))

# 1.2 Vector의 속성 ----
# (1) 데이터의 개수 : length(vector)
length(age3)

# (2) element의 이름 : names(vector)
income <- c(10000, 3500, 4000)
names(income)

# NULL : object가 없다는 뜻
# object : data, graph
names(income) <- c("김준회","이민수","김경태")
income
# 김경태 - ECG 대표님. 데이터 분석가

names(income) <- NULL
income
names(income) <- c("kim","lee")
income
names(income) <- NULL
# 1.3 Vector의 Index ----
# 첫 번째 element를 1로 인식함/ java, python 이랑 다른 점
income[1]
# 1.4 Vector의 슬라이싱 ----
income[1:2]
height <- c(170,171,178,174,180,163,181,168,168)
length(height)
height[1:3]

# 문제 7
# 1,4,5,8 번째의 값을 한 번에 가져오세요
height[c(1,4,5,8)]
height[1:3]
height[c(1,2,3)]
height[1,2,3]
mode(height)
class(height)
str(height)
# Vector 만드는 법인 c(), :, seq, sequence, rep() 의 리턴값은 Vector
# 1:3 -> c(1,2,3) : 3개 element
# 1 -> c(1) : 1개 element

# 문제 8
# 4~9 번째의 값을 한 번에 가져오세요.
height[4:9] # 리턴값도 vector. vector를 슬라이싱 하면 vector
height[c(4,5,6,7,8,9)]
# 문제 9
# 짝수 번째의 값을 한 번에 가져오세요.
height[seq(from=2,to=9,by=2)]
height[seq(from=2,to=length(height),by=2)]

# 1.5 Vector의 연산 ----
v1 <- 1:3
v2 <- 4:6
v1+v2 # for문을 쓰지 않아도 연산이 됨 : Vectorization(벡터화)

v3 <- 1:6
v1+v3 # Recycling Rule : 재사용규칙(v1을 재사용함) 

v4 <- 1:8
v1 + v4

# 2. Factor ----
# 하나의 열로 구성되어 있음, 1차원 구조
# 집단으로 인식함
# 하나의 유형으로만 이루어짐(vector를 가지고 만들기 때문에)
# 범주형 자료 = 질적 자료 = 그룹 = 집단

# 2.1 Factor 만들기 ----
# factor(vector, labels= , levels= , ordered = )
bt <- c("b","ab","b","a","o","o","ab")
# bt는 a집단, b집단, ab집단, o집단으로 인식하지 않음
btFactor1 <- factor(bt)
btFactor1 # 집단의 순서도 존재
btFactor2 <- factor(bt,
                    labels = c("A형","AB형","B형","O형") 
                    ) # display를 바꾸고 싶을 때
btFactor3 <- factor(bt,
                    levels = c("a","b","ab","o"))
btFactor3

btFactor4 <- factor(bt,
                    levels = c("a","b","ab","o"),
                    labels = c("A형","B형","AB형","O형")
                    )
btFactor5 <- factor(bt,
                    levels  = c("a","b","ab","o"),
                    labels  = c("A형","B형","AB형","O형"),
                    ordered = TRUE #순서형 자료
                    )
btFactor5 
# ordered = FALSE : 명목형 자료(default)

# 자료
# 1) 질적 자료 = 범주형 자료
#   a) 명목형 : factor() - 종교, 혈액형
#   b) 순서형 : factor(ordered = TRUE) - 강의만족도(만족,불만족,매우만족 등)
# 2) 양적 자료

# 2.2 Factor의 속성 ----
# 집단의 이름과 개수 : levels(factor), length(levels(btFactor1))
levels(btFactor1)
length(levels(btFactor1))
# factor의 집단의 이름은 글자로 보이지만
# 실질적으로 숫자로 인식하고 있음
# 숫자는 글자보다 메모리를 덜 차지함
mode(btFactor5)

# 3. Matrix ----
# 행과 열로 구성되어 있음, 2차원 구조
# 하나의 데이터 유형만 가짐
# Vector의 확장 : vectorization, recycling rule(Matrix를 만들 때)이 적용됨
v1 <- 1:3
v2 <- 4:6
v3 <- 1:6
# (1) rbind(vector1, vector2, ...) - 행 기준으로
M1 <- rbind(v1,v2,v3) # 행렬은 변수를 대문자로 표기하는 것이 관례
M1
# (2) cbind(vector1, vector2, ...) - 열 기준으로
M2 <- cbind(v1,v2,v3)
M2
dim(M2)
# (3) matrix(vector, nrow=, ncol=, byrow = TRUE)
matrix(1:4, nrow=2, ncol=2)
matrix(1:4, nrow=2, ncol=2, byrow=TRUE)
matrix(1:6, nrow=2, ncol=2) # 행렬 구조 개수만큼만 만들어지고 컷팅
# 3.2 Matrix의 Slicing ----
# matrix[rowindex, colindex]
A <- matrix(1:9,nrow=3,ncol=3)
A
A[3,] # vector
A[3, , drop=FALSE] #matrix 형태 유지
A[c(1,3),] # 1행, 3열 가져오기
A[ ,3, drop=FALSE]
A[,c(1,3)]
A[c(2,3),c(1,3)]

# 3.3 Matrix의 연산 ----
# (1) 덧셈과 뺄셈
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)
A;B
A+B # vectorization - index가 같은 값끼리 더해줌

# (2) 곱셉 : %*%
A %*% B # 행렬의 곱 A X B
A * B # 각각의 엘리먼트가 곱해짐. 의미가 없는 값
B %*% A # A%*%B와 다르
# (3) 역행렬(Inverse Matrix) - 역행렬을 사용하면 연립방정식을 빨리 풀 수 있음
# solve(matrix)
solve(A)
A <- matrix(c(1,1,-1,1),nrow=2,ncol=2)
B <- matrix(c(3,1),nrow=2,ncol=1)
solve(A)%*%B
# (4) 전치행렬(Transpose Matrix)
# 행과 열을 바꿈
# t(matrix)
A
t(A)
B
t(B)

# 4. Array ----
# 다차원 구조
# 하나의 데이터 유형만 가짐(array(vector, dim))
# 4.1 Array 만들기 ----
# array(vector, dim = num) : dim은 차원
array(1:4, dim = 10) # dim=10 - element가 10개인 1차원 array이자 vector
array(1:9, dim = c(3,3)) # 2차원 구조. array이자 matrix
array(1:9, dim = c(3,3,2)) # 3차원 구조 array

# 4.2 Array 속성 ----
# dim(array) : ?차원
dim(array(1:9, dim = c(3,3,2)))

# 5. Data.Frame ----
# 행과 열로 구성되어 있음, 2차원 구조
# 여러 개의 데이터 유형을 가질 수 있음
# 단, 하나의 열에는 하나의 데이터 유형만 가짐
# R에서 기본적으로 데이터라고 하면 Data.Frame이다
# Recylcing Rule 이 작동하지 않음 - 데이터 개수가 맞아야함
# data.frame 슬라이싱 리턴값은 list

# 5.1 Data.Frame 만들기 ----
# data.frame(vector, matrix)
id      <- 1:3
hobby   <- c("영화감상", "자전거타기", "맨몸운동")
movie   <- c(1,0.5,10)
traffic <- c(100,100,40)
survey  <- data.frame(id,hobby,movie,traffic)
survey
View(survey)

# 6. List ----
# 가장 유연한 형태의 데이터
# element로 vector, fator, matrix, array , data.frame, list를 가질 수 있다.
# list는 원소별 메모리 사이즈가 다를 수류 있음
# result[1] : 리턴값이 리스트 
# result[[1]] : 리턴값이 엘리먼트의 데이터 종류

# 6.1 List 만들기 ----
# list(vector, factor, matrix, array, data.frame, list)
genderFactor <- factor(c("남자","남자","여자","남자","남자"))

result <- list(hobby,genderFactor,survey)
result

result[1]   # 최종 결과 : list
result[[1]] # 최종 결과 : vector

