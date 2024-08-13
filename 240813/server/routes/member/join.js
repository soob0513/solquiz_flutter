// routes/apiRoutes.js
const express = require('express');
const joinrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 회원가입
joinrou.post('/join', async (req, res) => {
    const { id, pw, name, phone, email } = req.body;
    console.log("loginfield: " , id, pw, name, phone, email);

    let connection;
    try {
        const connection = await connectToOracle();
        console.log("loginpage connect success"); // 연결 성공 시 "success" 출력
        const sql = `select * from TB_MEMBER where MEM_ID = '${id}' AND MEM_PW = '${pw}'`;
        const result = await connection.execute(sql);
        console.log("sql 결과 : ", result.rows);

        if (result.rows.length > 0) {
            res.json('success');
            
        }else {
            console.log('로그인 실패');

            res.json('failed');

        }
        await connection.close();
        
    }catch (error) {
        console.error('SQL error:', error);
        res.status(500).json({ error: 'Failed to execute query', details: error.message });
      } finally {
        
    }

  });

  // 라우터를 모듈로 내보냅니다.
module.exports = joinrou;