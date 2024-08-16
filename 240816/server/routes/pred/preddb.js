// routes/apiRoutes.js
const express = require('express');
const moment = require('moment');
const predrou = express.Router();

const connectToOracle = require('../../config/dbConn');
// 게시판 조회 함수
predrou.post('/predselect', async (req, res) => {
  function formatDateString(isoDateString) {
    const date = new Date(isoDateString);

    const year = date.getUTCFullYear();
    const month = String(date.getUTCMonth() + 1).padStart(2, '0');
    const day = String(date.getUTCDate()).padStart(2, '0');
    const hour = String(date.getUTCHours()).padStart(2, '0');
    const minute = String(date.getUTCMinutes()).padStart(2, '0');

    return `${year}-${month}-${day} ${hour}:${minute}`;
  }
    const { initialDay } = req.body; 
    console.log(initialDay);
    const sql = "SELECT * FROM TB_PREDICTION WHERE TRUNC(PRED_DATE) = TO_DATE('"+initialDay+"', 'YYYY-MM-DD')"
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
      let pred = {
              idx : [],
              plant_idx : [],
              created_at : [],
              pred_power : [],
              pred_data : [],
              actual : []
          }
      console.log("ans의 값은 : ",ans)
      for(let i=0;i<result.rows.length;i++){
        pred.idx.push(ans[i][0]);
        pred.plant_idx.push(ans[i][1]);
        pred.created_at.push(formatDateString(ans[i][2]));
        pred.pred_power.push(ans[i][3]);
        pred.pred_data.push(formatDateString(ans[i][4]));
        pred.actual.push(ans[i][5]);

      }
      console.log("pred: ",pred)
      res.json(pred)

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
module.exports = predrou;