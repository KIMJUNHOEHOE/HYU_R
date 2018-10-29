# RStudio : ctrl enter / R : ctrl + r (실행 명령)
# 
# Alt + - : 할당 연산자
#
# 한 줄 삭제 : ctrl + d
# 
# 콘솔 clear : ctrl + l
# 
# ctrl + shit + 1,2,3,4,5,6~ : 해당 화면 늘리기
# ctrl + 숫자 : 해당 화면으로 커서 옮기기
# # : 주석 - 한 줄 처리
# ctrl + shift + c : 주석처리/ 해제
# 
# 대소문자를 구분함 - case sensitive
# 
# ---- : 책갈피
# 연산자(Operator)
# 
# 산술 연산자 : +, -, *, /, **, ^, %%, %/%
#   %% : 나머지 , %/% 몫

3+4; 3-4;
3^4
3**4
3%%4
3%/%4

3^(1/2)
sqrt(3)

# 1.2 할당 연산자 ----
# <-, =
# <- : 일반적인 할당 연산자
# =  : 함수 안의 argument를 설정할 때
x <- 10
y = 100
# 1.3 비교 연산자 ----
# >, >=, <, <=, ==, !=, !
# 데이터의 슬라이싱 때 사용
3 > 4
3 >= 4
3 < 4
3 <= 4
3 == 4
3 != 4
!(3==4)용

# 1.4 논리 연산자 ----
# & , |(pipe) 
# 데이터의 슬라이싱
(3>4) & (5>4)
(3>4) | (5>4)

# 2. 데이터의 유형
# 2.1 수치형(Numeric) ----
# (1) 정수(integer)
x1 <- 10
# (2) 실수(double)
x2 <- 10.2
# 2.2 문자형(Character) ----
x3 <- 'Love is not feeling.'
x4 <- "Love is choice."
# 2.3 논리형(Logical) ----
x5 <- FALSE
x6 <- TRUE

# 3. 데이터의 유형을 알아내기 ----
# 3.1 mode(data) ----
# mode의 리턴값은 character
mode(x1)
mode(x3)
# 3.2 is.xxxx(data) ----
# is.xxxx(data)의 리턴값은 Logical
is.numeric(x1)
is.character(x3)
is.logical(x6)

# 4. 강제적으로 데이터 유형을 변경하기 ----
# as.xxxx(data) # 원 데이터 타입은 변경되지 않음
# data <- as.xxxx(data) # 할당 연산자를 통해 원 데이터 변경하기
x7 <- "10"
as.numeric(x7) 
as.integer(x7)
as.double(x7)
as.integer(x3)
as.numeric(x5)
as.numeric(x6)
as.character(x5)
as.logical(x1)
as.logical(x3)
as.logical("FALSE")
as.logical(1)
# 데이터 유형의 우선순위
# character > numeric > logical
# 0은 FALSE
# 0 이외에는 TRUE
as.logical(-1)
as.logical(0)
