SELECT * FROM TB_SOLARPLANT;
SELECT * FROM TB_SOLAR_BOARD;
SELECT * FROM TB_SOLAR_COMMENT;
COMMIT;

DELETE FROM TB_SOLAR_BOARD WHERE PLACE = '����';

UPDATE TB_SOLARPLANT SET PLACE = '???? / ????' WHERE MEM_ID = 'smhrd2';
UPDATE TB_SOLARPLANT SET SB_TYPE = 'InLand' WHERE MEM_ID = 'smhrd2';
UPDATE TB_SOLARPLANT SET PLANT_POWER = 10 WHERE MEM_ID = 'apple';

UPDATE TB_SOLAR_BOARD SET SB_IDX = 1 WHERE PLANT_POWER_SUM = 20;


SELECT * FROM TB_SOLAR_BOARD;

ALTER TABLE TB_SOLARPLANT DROP COLUMN CREATED_AT;

ALTER TABLE TB_SOLARPLANT DROP COLUMN SB_TYPE;
ALTER TABLE TB_SOLARPLANT DROP COLUMN PLANT_TEL;
ALTER TABLE TB_SOLARPLANT ADD SB_TYPE VARCHAR(10);

DELETE FROM TB_SOLAR_BOARD WHERE SB_IDX = 6;

SELECT * FROM TB_SOLARPLANT;
SELECT * FROM TB_SOLAR_COMMENT;

SELECT * FROM TB_SOLAR_BOARD;

SELECT * FROM TB_SOLAR_BOARD WHERE SB_IDX = 5;
INSERT INTO TB_SOLAR_BOARD VALUES (2, 'Coast', 20, 'smhrd2', '???? / ??? / ???');

INSERT INTO TB_SOLAR_BOARD VALUES (3, 'Inland', 27, 'apple', '????');
INSERT INTO TB_SOLAR_BOARD VALUES (4, 'Coast', 30, 'heewon', '???? / ???? / ??');
INSERT INTO TB_SOLAR_BOARD VALUES (5, 'Inland', 33, 'smhrd2', '???? / ??? / ???');
SELECT * FROM TB_SOLARPLANT;
insert into TB_SOLARPLANT values(SEQ_PLANT_IDX, 'applePlant', 'applePlant', 'applePlantAddress', '15','????', 'Inland');
insert into TB_SOLARPLANT values(SEQ_PLANT_IDX.NEXTVAL, 'apple', 'addPlant', 'applePlantAddress', '15','????', 'Inland');

delete from TB_SOLARPLANT where MEM_ID = 'smhrd2';

SELECT * FROM TB_MEMBER;
rollback;
insert into TB_MEMBER values ('continue','continue','������','01012345678', 'continue@continue.com', sysdate, 'a');
insert into TB_MEMBER values ('film','film','�ڼ���','01012345678', 'film@film.com', sysdate, 'a');
insert into TB_MEMBER values ('magazine','magazine','��α�','01012345678', 'magazine@magazine.com', sysdate, 'a');
insert into TB_MEMBER values ('name','name','�Ǽ���','01012345678', 'name@name.com', sysdate, 'a');
insert into TB_MEMBER values ('picture','picture','ȫ����', '01012345678','picture@picture.com',  sysdate, 'a');
insert into TB_MEMBER values ('recent','recent','������','01012345678','recent@recent.com',  sysdate, 'a');
insert into TB_MEMBER values ('rise','rise','�ν°�', '01012345678', 'rise@rise.com', sysdate, 'a');
insert into TB_MEMBER values ('hot','hot','�ֽ�ö','01012345678', 'hot@hot.com',  sysdate, 'a');
insert into TB_MEMBER values ('maestro','maestro','������', '01012345678','maestro@maestro.com',  sysdate, 'a');
insert into TB_MEMBER values ('world','world','������', '01012345678','world@world.com',  sysdate, 'a');
insert into TB_MEMBER values ('flower','flower','����ȣ','01012345678', 'flower@flower.com',  sysdate, 'a');
insert into TB_MEMBER values ('anyone','anyone','������','01012345678','anyone@anyone.com',  sysdate, 'a');
insert into TB_MEMBER values ('crush','crush','�̼���','01012345678', 'crush@crush.com', sysdate, 'a');
insert into TB_MEMBER values ('mymy','mymy','����','01012345678','mymy@mymy.com', sysdate, 'a');
insert into TB_MEMBER values ('campfire','campfire','���Ѽ�','01012345678','campfire@campfire.com',  sysdate, 'a');
insert into TB_MEMBER values ('gee','gee','���¿�','01012345678','gee@naver.com',  sysdate, 'a');
insert into TB_MEMBER values ('forever','forever','��ȿ��','01012345678','forever@forever.com',  sysdate, 'a');
insert into TB_MEMBER values ('pinktape','pinktape','������','01012345678','pinktape@pinktape.com',  sysdate, 'a');
insert into TB_MEMBER values ('hoot','hoot','������','01012345678','hoot@hoot.com',  sysdate, 'a');
insert into TB_MEMBER values ('genie','genie','Ȳ�̿�','01012345678','genie@genie.com',  sysdate, 'a');
insert into TB_MEMBER values ('theboys','theboys','�ּ���','01012345678','theboys@theboys.com',  sysdate, 'a');
insert into TB_MEMBER values ('party','party','������','01012345678','party@party.com',  sysdate, 'a');
insert into TB_MEMBER values ('holiday','holiday','������','01012345678','holiday@holiday.com',  sysdate, 'a');
insert into TB_MEMBER values ('lionheart','lionheart','�ڼ���','01012345678','lionheart@lionheart.com',  sysdate, 'a');
insert into TB_MEMBER values ('igotaboy','igotaboy','�̼���','01012345678','igotaboy@igotaboy.com',  sysdate, 'a');
select * from TB_SOLAR_COMMENT;
select * from TB_SOLAR_BOARD;
select * from TB_SOLARPLANT;
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'continue','continue', 'continue', 1, '���� / ��õ / ���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'film','film','film', 3, '���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'magazine','magazine', 'magazine', 5, '����', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'picture','picture', 'magazine',4, '���� / ����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'recent','recent', 'magazine',3, '����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'rise','rise', 'magazine',2, '���� / ���� / �泲', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'hot','hot', 'magazine',1, '�뱸 / ���', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'maestro','maestro', 'magazine',2, '�λ� / ��� / �泲', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'world','world', 'magazine',5, '����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'flower','flower', 'magazine',7, '���� / ��õ / ���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'anyone','anyone', 'magazine',5, '����', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'crush','crush', 'magazine',7, '���� / ����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'mymy','mymy', 'magazine',5, '����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'campfire','campfire', 'magazine',1, '���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'gee','gee', 'magazine',2, '���� / ���� / �泲', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'forever','forever', 'magazine',3, '�뱸 / ���', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'pinktape','pinktape', 'magazine',3, '�λ� / ��� / �泲', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'hoot','hoot', 'magazine',6, '����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'genie','genie', 'magazine',7, '���� / ��õ / ���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'theboys','theboys', 'magazine',2, '����', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'party','party', 'magazine',1, '���� / ����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'holiday','holiday', 'magazine',2, '����', 'Coast');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'lionheart','lionheart', 'magazine',3, '���', 'Inland');
insert into TB_SOLARPLANT values (SEQ_PLANT_IDX.NEXTVAL, 'igotaboy','igotaboy', 'magazine',3, '���� / ���� / �泲', 'Coast');

insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 1, 'continue', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 2, 'film', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 3, 'magazine', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 4, 'picture', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 5, 'recent', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 1, 'rise', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 2, 'hot', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 3, 'maestro', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 4, 'world', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 5, 'flower', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 1, 'anyone', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 2, 'crush', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 3, 'mymy', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 4, 'campfire', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 5, 'gee', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 1, 'forever', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 2, 'pinktape', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 3, 'hoot', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 4, 'genie', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 5, 'theboys', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 1, 'party', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 2, 'holiday', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 3, 'lionheart', 'wait');
insert into TB_SOLAR_COMMENT values(SEQ_COMMENT_IDX.NEXTVAL, 4, 'igotaboy', 'wait');

commit;
SELECT * FROM TB_SOLAR_COMMENT;
drop sequence SEQ_RECRUIT_IDX;
SEQ_RECRUIT_IDX
CREATE SEQUENCE SEQ_RECRUIT_IDX START WITH 6 MINVALUE 6 INCREMENT BY 1;
CREATE SEQUENCE SEQ_COMMENT_IDX START WITH 3 MINVALUE 3 INCREMENT BY 1;

SELECT * FROM USER_SEQUENCES;
ALTER SEQUENCE SEQ_RECRUIT_IDX RESTART WITH 6;
COMMIT;

SELECT MEM_ID, PLANT_POWER, PLACE, SB_TYPE 
FROM TB_SOLARPLANT
WHERE MEM_ID IN (SELECT MEM_ID 
                FROM TB_SOLAR_COMMENT 
                WHERE SB_IDX = 1);
                
SELECT A.PLANT_POWER, A.PLACE, A.SB_TYPE 
FROM TB_SOLARPLANT A JOIN TB_SOLAR_COMMENT B
ON (A.MEM_ID = B.MEM_ID);

DELETE FROM TB_SOLARPLANT WHERE MEM_ID = 'party';
DELETE FROM TB_SOLARPLANT WHERE MEM_ID = 'theboys';