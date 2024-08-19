// routes/apiRoutes.js
const express = require('express');
const smprecrou = express.Router();

const connectToOracle = require('../../config/dbConn');


// smp,rec 가져오기
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
module.exports = smprecrou;