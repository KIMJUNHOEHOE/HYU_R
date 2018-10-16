# Lecture : Import Data
# Date : October 8th, 2018

# 1. txt
# 2. csv
# 3. excel
# 4. DB

# 1. txt ----
# 1.1 separator : one blank ----
# data <- read.table(file="directory/filename.txt", header = TRUE, sep=" ")
blank <- read.table(file = "c:/R/BigData/blank.txt", header = TRUE, sep=" ")
blank # data.frame 구조 - 외부에서 읽어오는 데이터는 대부분 데이터프레임
mean(blank$age)

# 1.2 seperator : comma ----
# data <- read.table(file="directory/filename.txt", header = TRUE, sep=",")
comma <- read.table(file = "c:/R/BigData/comma.txt", header = TRUE, sep=",")
comma # data.frame 구조 - 외부에서 읽어오는 데이터는 대부분 데이터프레임
table(comma$food)

# 1.3 seperator : tab ----
# data <- read.table(file="directory/filename.txt", header = TRUE, sep="\t")
tab <- read.table(file = "c:/R/BigData/tab.txt", header = TRUE, sep="\t")
tab # data.frame 구조 - 외부에서 읽어오는 데이터는 대부분 데이터프레임


# 2. csv ----
# Comma Seperated Value
# 엑셀의 특수한 형태
# data <- read.csv(file="directory/filename.csv", header = TRUE)
company <- read.csv(file="c:/R/BigData/company.csv", header = TRUE)
company

# 3. excel ----
# 기본 기능에서는 못 읽어옴
# package를 설치하고 로딩하면 됨
# "readxl" : 해들리 위컴

# 3.1 패키지 설치하기 ----
# install.packages("packageName")
install.packages("readxl")

# 인터넷이 안 되는 경우
# 1단계 : 인터넷이 되는 컴퓨터로 감
# 2단계 : USB or 외장하드에 해당 패키지 다운로드
# 3단계 : 보안검사를 통과한 후에 해당 컴퓨터에 복사
# 4단계 : 설치
install.packages("c:/R/BigData/antiword_1.1.zip", repos = NULL)
# repos : 서버의 위치 = 서버의 주소
# repos = NULL : 서버x : 로컬

# 3.2 패키지 로딩하기 ----
# 패키지를 컴퓨터 메모리에 올려서 R과 연결시키기
# library(packageName)
library(readxl)

# data <- readxl::read_excel(path = "directory/filename.xlsx", 
#                           sheet = "sheetName" or sheetIndex,
#                       col_names = TRUE)

reading <- readxl::read_excel(path = "c:/R/BigData/reading.xlsx",
                              sheet = "data",
                              col_names = TRUE)
reading

# NA : Missing Value(결측치)
# Imputation : 대체
# NULL : object(data, graph) 측면, object가 존재하지 않음

# 시트 이름을 모를 때
reading2 <- readxl::read_excel(path = "c:/R/BigData/reading.xlsx",
                              sheet = 1,
                              col_names = TRUE)
reading2

# working directory
# (1) 현재 설정된 작업공간 알아내기 : getwd()
getwd()

# (2) 새롭게 작업공간 설정하기 : setwd("directory")
setwd("c:/R/BigData/")
getwd()
reading3 <- readxl::read_excel(path = "reading.xlsx",
                               sheet = 1,
                               col_names = TRUE)
reading3
