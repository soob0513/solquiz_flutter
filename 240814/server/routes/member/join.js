// routes/apiRoutes.js
const express = require('express');
const joinrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 회원가입
joinrou.post('/joinpage', async (req, res) => {
    const { id, pw, name, phone, email } = req.body;
    console.log("joinfield: " , id, pw, name, phone, email);

    let connection;

    try {
        const connection = await connectToOracle();
        console.log("joinpage connect success"); // 연결 성공 시 "success" 출력
        const sql = `insert into TB_MEMBER values ('${id}', '${pw}', '${name}', '${phone}',' ${email}', SYSDATE, 'a')`;
        const result = await connection.execute(sql);
        console.log("회원가입 sql 결과 : ", result.rowsAffected);

        if (result.rowsAffected && result.rowsAffected > 0) {
            res.json('success');
            
        }else {
            console.log('회원가입 실패');

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