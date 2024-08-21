// routes/apiRoutes.js
const express = require('express');
const loginrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 마이페이지
loginrou.post('/mypage', async (req, res) => {
   const { userInfo } = req.body;
  // console.log('마이페이지 storage 넘겨받기 : ', userInfo);

   const id = userInfo.id;
   const pw = userInfo.pw;

    const sql = `select * from TB_MEMBER where MEM_ID = '${id}' AND MEM_PW = '${pw}'`;
    // console.log(sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
    
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      
      const result = await connection.execute(sql);
      const ans = result.rows
      let member = {
              mem_id : [],
              mem_pw : [],
              mem_name : [],
              mem_phone : [],
              mem_email : [],
              joined_at : [],
              mem_role : [],

          }
      console.log("member ans의 값은 : ", ans);
      for(let i=0;i<result.rows.length;i++){
        member.mem_id.push(ans[i][0]);
        member.mem_pw.push(ans[i][1]);
        member.mem_name.push(ans[i][2]);
        member.mem_phone.push(ans[i][3]);
        member.mem_email.push(ans[i][4]);
        member.joined_at.push(ans[i][5]);
        member.mem_role.push(ans[i][6]);
      }
      console.log("member: ", member);
      res.json(member);

      // 연결 해제 null
      await connection.close();
    } catch (error) {
      console.error('SQL error:', error);
      res.status(500).json({ error: 'Failed to execute query', details: error.message });
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.error('Error closing connection:', err);
        }
      }
    }
    
  });

  // 로그인 함수
  loginrou.post('/loginpage', async (req, res)=>{
    const { id, pw } = req.body;
    console.log("loginfield: " , id, pw);

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
module.exports = loginrou;