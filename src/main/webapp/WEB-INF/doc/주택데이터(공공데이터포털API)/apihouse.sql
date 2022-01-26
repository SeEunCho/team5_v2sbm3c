/* Table Name: 공공데이터포털 거래정보 */
/**********************************/
drop table apihouse;
CREATE TABLE apihouse(
        houseno                             NUMBER(10)       NOT NULL        PRIMARY KEY,
        rcode                               VARCHAR2(20)         NOT NULL,
        name                                VARCHAR2(100)        NOT NULL,
        area                                VARCHAR2(50)         NOT NULL,
        amount                              VARCHAR2(50)         NOT NULL,
        year                                VARCHAR2(30)         NOT NULL,
        cyear                               VARCHAR2(30)         NOT NULL,
        month                               VARCHAR2(20)         NOT NULL,
        lat                                 VARCHAR2(50)         NOT NULL,
        lon                                 VARCHAR2(50)         NOT NULL
);

COMMENT ON TABLE apihouse is '공공데이터포털 거래정보';
COMMENT ON COLUMN apihouse.houseno is '주택번호';
COMMENT ON COLUMN apihouse.rcode is '지역코드';
COMMENT ON COLUMN apihouse.name is '주택이름';
COMMENT ON COLUMN apihouse.area is '전용면적';
COMMENT ON COLUMN apihouse.amount is '거래 가격';
COMMENT ON COLUMN apihouse.year is '거래년도';
COMMENT ON COLUMN apihouse.cyear is '건축년도';
COMMENT ON COLUMN apihouse.month is '거래 월';
COMMENT ON COLUMN apihouse.lat is '위도';
COMMENT ON COLUMN apihouse.lon is '경도';


DROP SEQUENCE apihouse_seq;
CREATE SEQUENCE apihouse_seq
  START WITH 1                   
  MAXVALUE 99999
  MINVALUE 0
  NOCACHE                     
  NOCYCLE;

--- api통하여 데이터를 넣기때문에, 테스트로만 사용  
insert into apihouse(houseno, rcode ,name, area, amount, year, cyear, month, lat, lon)
values(apihouse_seq.nextval, '11110', '쌍문동 두산위브제니스2차', '93.45', '140,000', '2017', '2002',  '12', '35.43524', '111.2312344');

-- All
select houseno, rcode ,name, area, amount, year, cyear, month, lat, lon
from apihouse;

-- Part (사용자에게 법정동 코드, 거래년도, 거래월 입력값을 받음)
select houseno, rcode ,name, area, amount, year, cyear, month, lat, lon
from apihouse
where rcode='11110' and year='2017' and month='12';

-- 특정 구 에 속한 데이터 개수  count(*) as houses
select *
from apihouse
where rcode='11650';

select count(*)
from apihouse;

-- 사용자의 입력 단위 별 컬럼의 수
select rcode, year, month, count(*)
from apihouse
group by rcode, year, month
order by rcode;

-- 구 별 컬럼의 수
select count(*)
from apihouse
group by rcode
order by rcode;

commit;
-- update, delete 쿼리는 사용하지 않음.