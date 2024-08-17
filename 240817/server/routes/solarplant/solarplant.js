// routes/apiRoutes.js
// TB_SOLARPLANT
const express = require('express');
const solarplantrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 발전소 등록 / 추가하기
solarplantrou.post('/sp', async (req, res) => {
   const { id, plant_name, plant_addr, plant_power, place, sb_type} = req.body;
  
   console.log('발전소 등록 페이지 ', id, plant_name, plant_addr, plant_power, place, sb_type);

  const sql = `insert into TB_SOLARPLANT values(SEQ_PLANT_IDX.NEXTVAL, '${id}', '${plant_name}', '${plant_addr}', '${plant_power}','${place}', '${sb_type}')`;
  console.log(sql);
  if (!sql){
    return res.status(400).json({ error: 'SQL query is required' });
  }
  let connection;
  
  try {
    const connection = await connectToOracle();
    console.log("success"); // 연결 성공 시 "success" 출력

    const result = await connection.execute(sql);
    console.log('발전소 등록 result', result);
    if (result.rowsAffected > 0){
      res.json('success');
    }else {
      console.log('발전소 등록 실패');

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
}
);




// 라우터를 모듈로 내보냅니다.
module.exports = solarplantrou;