const express = require('express');
const recruitmorerou = express.Router();

const connectToOracle = require('../../config/dbConn');

recruitmorerou.post('/recruitmore', async (req, res) => {
    const { idx } = req.body;
    console.log('모집 게시판 상세 페이지', idx);

    const sql = `select PLANT_POWER, PLACE, SB_TYPE from TB_SOLARPLANT where MEM_ID in (select MEM_ID from TB_SOLAR_COMMENT where SB_IDX = ${parseInt(idx) +1})`
    console.log(sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      // console.log('여기입니다', result);
      const ans = result.rows
      
      let solar_board = {
              plant_power : [],
              place : [],
              sb_type : []
          }
      console.log("ans의 값은 : ", ans)
      for(let i=0;i<result.rows.length;i++){
        solar_board.plant_power.push(ans[i][0]);
        solar_board.place.push(ans[i][1]);
        solar_board.sb_type.push(ans[i][2]);
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
module.exports = recruitmorerou;