// routes/apiRoutes.js
const express = require('express');
const joinrou = express.Router();

const connectToOracle = require('../../config/dbConn');


// 아이디 중복 체크
joinrou.post('/checkduplicateId', async (req, res)=> {
  const { id } = req.body;
  console.log('아이디 중복 체크 : ', id);

  let connection;
  const sql = `select MEM_ID from TB_MEMBER where MEM_ID = '${id}'`;

  try {
    const connection = await connectToOracle();
    console.log("아이디 중복 검사 connection success");
    const result = await connection.execute(sql);
    console.log("아이디 중복 검사 결과 ", result);
    console.log("아이디 중복 검사 결과 2", result.rows.length);
    if (result.rows.length > 0){
      res.json('exists');
    }

    await connection.close();
  }catch (error) {
    console.error('SQL error:', error);
    res.status(500).json({ error: 'Failed to execute query', details: error.message });
  } finally {
    
}

});

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