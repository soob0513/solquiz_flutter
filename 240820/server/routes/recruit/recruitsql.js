// routes/apiRoutes.js
const express = require('express');
const recruitrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 게시판 조회 함수
recruitrou.post('/bselect', async (req, res) => {
    const sql = "select * from TB_SOLAR_BOARD where B_STATE = 'ing' union all select * from TB_SOLAR_BOARD where B_STATE = 'end'"
    console.log('피츄' ,sql);
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
              b_state : [],
          }
      console.log("ans의 값은 : ", ans)
      for(let i=0;i<result.rows.length;i++){
        solar_board.sb_idx.push(ans[i][0]);
        solar_board.sb_type.push(ans[i][1]);
        solar_board.plant_power_sum.push(ans[i][2]);
        solar_board.mem_id.push(ans[i][3]);
        solar_board.place.push(ans[i][4]);
        solar_board.b_state.push(ans[i][5]);
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
    const { id } = req.body;
    // console.log('모집글을 추가해보자', id);
    const sql = `select * from TB_SOLARPLANT where MEM_ID = '${id}'`;
    // console.log('모집글 추가 sql select : ', sql);
    

    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      // console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      const ans = result.rows;
      let solarplant = {
              plant_id : [],
              mem_id : [],
              plant_name : [],
              plant_addr : [],
              plant_power : [],
              place : [],
              sb_type : [],
      }
      // console.log("ans의 값은 : ", ans)
      for(let i=0;i<result.rows.length;i++){
        solarplant.plant_id.push(ans[i][0]);
        solarplant.mem_id.push(ans[i][1]);
        solarplant.plant_name.push(ans[i][2]);
        solarplant.plant_addr.push(ans[i][3]);
        solarplant.plant_power.push(ans[i][4]);
        solarplant.place.push(ans[i][5]);
        solarplant.sb_type.push(ans[i][6]);
      }
      // console.log('모집글 추가 solarplant : ', solarplant);
      // console.log('solarplant의 데이터를 확인 : ', solarplant.mem_id[0]);
      
      const sql2 = `insert into TB_SOLAR_BOARD values((select MAX(SB_IDX)+1 from TB_SOLAR_BOARD), '${solarplant.sb_type[0]}', ${parseInt(solarplant.plant_power[0])}, '${solarplant.mem_id[0]}', '${solarplant.place[0]}', 'ing')`;
      const result2 = await connection.execute(sql2);
      
      // console.log("모집글 추가 결과 : ", result);

      if (result.rows.length > 0) {
          res.json('success');
          
      }else {
          console.log('모집글 추가 실패');

          res.json('failed');
      }

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