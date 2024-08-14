// routes/apiRoutes.js
const express = require('express');
const recruitrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 게시판 조회 함수
recruitrou.post('/bselect', async (req, res) => {
    const sql = "select * from TB_SOLAR_BOARD"
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
      let solar_board = {
              sb_idx : [],
              sb_type : [],
              plant_power_sum : [],
              mem_id : [],
              place : [],
          }
      console.log("ans의 값은 : ", ans)
      for(let i=0;i<result.rows.length;i++){
        solar_board.sb_idx.push(ans[i][0]);
        solar_board.sb_type.push(ans[i][1]);
        solar_board.plant_power_sum.push(ans[i][2]);
        solar_board.mem_id.push(ans[i][3]);
        solar_board.place.push(ans[i][4]);
      }
      console.log("solar_board: ", solar_board);
      res.json(solar_board);

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

  // 모집글 추가
  recruitrou.post('/addrecruit', async (req, res) => {
    const sql = "select * from TB_SOLAR_BOARD"
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
      let solar_board = {
              sb_idx : [],
              sb_type : [],
              plant_power_sum : [],
              mem_id : [],
              place : [],
          }
      console.log("ans의 값은 : ", ans)
      for(let i=0;i<result.rows.length;i++){
        solar_board.sb_idx.push(ans[i][0]);
        solar_board.sb_type.push(ans[i][1]);
        solar_board.plant_power_sum.push(ans[i][2]);
        solar_board.mem_id.push(ans[i][3]);
        solar_board.place.push(ans[i][4]);
      }
      console.log("solar_board: ", solar_board);
      res.json(solar_board);

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
module.exports = recruitrou;