// routes/apiRoutes.js
const express = require('express');
const smprecrou = express.Router();

const connectToOracle = require('../../config/dbConn');


smprecrou.post('/smprecselect', async (req, res)=>{
    // const sql = 'SELECT * FROM (SELECT * FROM tb_electric_information ORDER BY CREATED_AT DESC) WHERE ROWNUM = 1';

    let connection;
    try {
        const connection = await connectToOracle();
        console.log("loginpage connect success"); // 연결 성공 시 "success" 출력
        const sql = 'SELECT * FROM (SELECT * FROM TB_ELECTRIC_INFORMATION ORDER BY CREATED_AT DESC) WHERE ROWNUM = 1';
        const result = await connection.execute(sql);
        console.log("sql 결과 : ", result.rows);

        if (result.rows.length > 0) {
            res.json(result.rows);
            
        }else {
            console.log('결과 못 가져옴 ㅋㅋ');

            res.json('failed');

        }
        await connection.close();
        
    }catch (error) {
        console.error('SQL error:', error);
        res.status(500).json({ error: 'Failed to execute query', details: error.message });
        } finally {
        
    }

});

smprecrou.post('/mainmoney', async (req, res)=>{
    console.log("머니머니머니머니 메인 머니머니머니머니");
    const { date } = req.body;
    let anss = date + " 00:00:00";

    let connection;
    try {
        function formatDateString(isoDateString) {
            const date = new Date(isoDateString);
        
            const year = date.getUTCFullYear();
            const month = String(date.getUTCMonth() + 1).padStart(2, '0');
            const day = String(date.getUTCDate()).padStart(2, '0');
            const hour = String(date.getUTCHours()).padStart(2, '0');
            const minute = String(date.getUTCMinutes()).padStart(2, '0');
        
            return `${year}-${month}-${day} ${hour}:${minute}`;
        }

        const connection = await connectToOracle();
        console.log("loginpage connect success"); // 연결 성공 시 "success" 출력

        // 발전용량 조회
        const sql = 'SELECT PLANT_POWER FROM TB_SOLARPLANT where PLANT_IDX = 99';
        const result = await connection.execute(sql);
        console.log("sql 결과 : ", result.rows[0][0]);
        plant_power = result.rows[0][0];
        console.log("plant_power", plant_power)

        console.log(anss);
        // smp,rec 정보 조회
        const sql2 = "SELECT CREATED_AT,AVG_SMP,AVG_REC FROM TB_ELECTRIC_INFORMATION WHERE CREATED_AT =TO_DATE('"+anss+"', 'YYYY-MM-DD HH24:MI:SS')"
        const result2 = await connection.execute(sql2);
        console.log("sql2 결과 : ", result2.rows);
        let smp = result2.rows[0][1]
        let rec = result2.rows[0][2]
        let b = smp + rec;
        
        
        const sql3 = "select count(*) from tb_generated_power where TRUNC(GENERATED_AT) = TO_DATE('"+date+"','YYYY-MM-DD')";
        const result3 = await connection.execute(sql3);
        console.log("sql3 결과 : ", result3.rows);
        let days = result3.rows[0][0] 
        console.log("days : ",days);

        let ans = plant_power * b * days
        ans /= 1300;
        ans = Math.round(ans)

        del = days * plant_power


        console.log("최종 전달 값 : ",plant_power,ans,del,)
        if (result.rows.length > 0) {
            res.json(`${plant_power}-${ans}-${del}`);
            
        }else {
            console.log('결과 못 가져옴 ㅋㅋ');

            res.json('failed');

        }
        await connection.close();
        
    }catch (error) {
        console.error('SQL error:', error);
        res.status(500).json({ error: 'Failed to execute query', details: error.message });
        } finally {
        
    }

});


smprecrou.post('/money', async (req, res)=>{
    console.log("수익 머니머니머니머니머니");
    const { month } = req.body; 
    try {
        function formatDateString(isoDateString) {
            const date = new Date(isoDateString);
        
            const year = date.getUTCFullYear();
            const month = String(date.getUTCMonth() + 1).padStart(2, '0');
            const day = String(date.getUTCDate()).padStart(2, '0');
            const hour = String(date.getUTCHours()).padStart(2, '0');
            const minute = String(date.getUTCMinutes()).padStart(2, '0');
        
            return `${year}-${month}-${day} ${hour}:${minute}`;
          }

        const connection = await connectToOracle();
        console.log("loginpage connect success"); // 연결 성공 시 "success" 출력

        // 발전용량 조회
        const sql = 'SELECT PLANT_POWER FROM TB_SOLARPLANT where PLANT_IDX = 99';
        const result = await connection.execute(sql);
        console.log("sql 결과 : ", result.rows[0][0]);
        plant_power = result.rows[0][0];

        // smp,rec 정보 조회
        const sql2 = 'SELECT CREATED_AT,AVG_SMP,AVG_REC FROM TB_ELECTRIC_INFORMATION WHERE EXTRACT(YEAR FROM CREATED_AT) = 2024 AND EXTRACT(MONTH FROM CREATED_AT) = '+month;
        const result2 = await connection.execute(sql2);
        console.log("sql2 결과 : ", result2.rows);
        let smpRecInfo = {
            createAt : [],
            smpPlusRec : []
        }
        for(let i=0;i<result2.rows.length;i++){
            smpRecInfo.createAt.push(formatDateString(result2.rows[i][0]));
            smpRecInfo.smpPlusRec.push(result2.rows[i][1] + result2.rows[i][2]);
        }
        console.log(smpRecInfo);

        a = 1;
        lim = 0;
        if (month == '8'){
            lim = 19;
        } else if (month == '7') {
            lim = 31;
        } else if (month == '6') {
            lim = 30;
        }
        console.log("lim : " + lim);
        let timeCnt = {
            GENERATED_AT : [],
            cnt : []
        }
        // 일수별 시간 갯수
        for(let i=1; i<lim; i++) {
            if (i<10) {
                i = '0' + i.toString();
            }
            console.log("i : ",i);
            console.log(typeof i);
            const sql3 = "select count(*) from tb_generated_power where TRUNC(GENERATED_AT) = TO_DATE('2024-06-"+i+"','YYYY-MM-DD')";
            const result3 = await connection.execute(sql3);
            console.log("sql3 결과 : ", result3.rows);
            timeCnt.GENERATED_AT.push(parseInt(i));
            timeCnt.cnt.push(result3.rows[0][0]);
        }
        
        console.log(timeCnt);

        // 총 수익
        let ans = 0 ;
        for(let i=0;i<timeCnt.GENERATED_AT.length;i++){
            ans += plant_power * timeCnt.cnt[i] * smpRecInfo.smpPlusRec[i]
            console.log(ans);
        }
        ans /= 1300;
        ans = Math.round(ans)
        console.log("ans : ",ans);
        if (result.rows.length > 0) {
            res.json(ans);
            
        }else {
            console.log('결과 못 가져옴 ㅋㅋ');

            res.json('failed');

        }
        await connection.close();
        
    }catch (error) {
        console.error('SQL error:', error);
        res.status(500).json({ error: 'Failed to execute query', details: error.message });
        } finally {
        
    }

});

module.exports = smprecrou;