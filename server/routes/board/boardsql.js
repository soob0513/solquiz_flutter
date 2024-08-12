// routes/apiRoutes.js
const express = require('express');
const boardrou = express.Router();

const connectToOracle = require('../../config/dbConn');
// 게시판 조회 함수
boardrou.post('/bselect', async (req, res) => {
    const { sql } = req.body;
    console.log(sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      const ans = result.rows
      let board = {
              idx : [],
              title : [],
              filename : [],
              created_at : [],
              view : [],
              likes : [],
              mem_id : [],
              content : [],
          }
      console.log("ans의 값은 : ",ans)
      for(let i=0;i<result.rows.length;i++){
        board.idx.push(ans[i][0]);
        board.title.push(ans[i][1]);
        board.content.push(ans[i][7]);
        board.filename.push(ans[i][2]);
        board.created_at.push(ans[i][3]);
        board.view.push(ans[i][4]);
        board.likes.push(ans[i][5]);
        board.mem_id.push(ans[i][6]);
      }
      console.log("borad: ",board)
      res.json(board)

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

  // 라우터를 모듈로 내보냅니다.
module.exports = boardrou;