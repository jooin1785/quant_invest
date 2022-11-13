# library가 설치되지 않았다면 명령창에 install.packages('library') 먼저 실행

# API를 이용한 데이터 다운로드

url.aapl = "https://www.quandl.com/api/v3/datasets/WIKI/AAPL/data.csv?api_key=xw3NU3xLUZ7vZgrz5QnG"
data.aapl = read.csv(url.aapl)
head(data.aapl)

# 주가 다운로드

library(quantmod)
getSymbols("AAPL")
head(AAPL)
chart_Series(Ad(AAPL))
# Ad()함수를 통해 수정주가만 선택한 후 chart_series() 함수를 이용하여 시계열 그래프 생성

# 최근 3년 주가 확인(auto.assign은 티커가 아닌 다른 변수명을 할당하고 싶을 때 사용)
data = getSymbols('AAPL',
                  from = '2019-11-12', to = '2022-11-13',
                  auto.assign = FALSE)
head(data)

# 여러 티커를 불러올 수 있다.
ticker = c('META', 'NVDA')
getSymbols(ticker)
head(FB)
head(NVDA)

# 국내 종목 주가 다운로드
# 변수에 마침표가 있으므로 ``를 붙인다.
getSymbols("005930.KS",
           from = '2015-01-01', to='2022-11-11')
tail(Ad(`005930.KS`))
tail(Cl(`005930.KS`))

getSymbols("068760.KQ",
           from = '2000-01-01', to = '2022-11-11')
tail(Cl(`068760.KQ`))

# FRED 데이터 다운로드
getSymbols('DGS10', src='FRED')
data = DEXKOUS["2016::"] # 2016년 자료부터 데이터 표시
chart_Series(data)
getSymbols('DEXKOUS', src='FRED')
tail(DEXKOUS)

# 크롤링
library(rvest)
library(httr)

url = 'https://finance.naver.com/news/news_list.nhn?mode=LSS2D&section_id=101&section_id2=258'
data = GET(url)
print(data)
data_title = data %>%
  read_html(encoding = 'EUC-KR') %>%
  html_nodes('dl') %>%
  html_nodes('.articleSubject') %>% # 클래스 속성 이름 앞에는 마침표
  html_nodes('a') %>%
  html_attr('title')

print(data_title)
