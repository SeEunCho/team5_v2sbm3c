/**********************************/
/* Table Name: 지역(구) 정보 */
/**********************************/
drop table region;
CREATE TABLE region(
        regionno                            NUMBER(10)       NOT NULL        PRIMARY KEY,
        regionCode                          VARCHAR2(30)         NOT NULL,
        name                                VARCHAR2(30)         NOT NULL
);

COMMENT ON TABLE region is '지역(구) 정보';
COMMENT ON COLUMN region.regionno is '지역번호';
COMMENT ON COLUMN region.regionCode is '법정동코드';
COMMENT ON COLUMN region.name is '(구) 이름';

DROP SEQUENCE region_seq;
CREATE SEQUENCE region_seq
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE; 
  

insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11110', '종로구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11140', '중구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11170', '용산구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11200', '성동구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11215', '광진구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11230', '동대문구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11260', '중랑구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11290', '성북구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11305', '강북구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11320', '도봉구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11350', '노원구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11380', '은평구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11410', '서대문구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11440', '마포구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11470', '양천구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11500', '강서구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11530', '구로구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11545', '금천구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11560', '영등포구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11590', '동작구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11620', '관악구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11650', '서초구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11680', '강남구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11710', '송파구');
insert into region(regionno, regionCode, name)
values(region_seq.nextval, '11740', '강동구');

select regionCode, name
from region
order by name;

select count(*) from region;
