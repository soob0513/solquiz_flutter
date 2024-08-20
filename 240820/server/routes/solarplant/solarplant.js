// routes/apiRoutes.js
// TB_SOLARPLANT
// 1. '/sp' : 발전소 등록 / 추가하기
// 2. '/plantname' : 메인페이지에서 발전소 이름 띄우기
const express = require('express');
const solarplantrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 1. '/sp' : 발전소 등록 / 추가하기
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


// 2. '/plantname' : 메인페이지에서 발전소 이름 띄우기
solarplantrou.post('/plantname', async (req, res) => {
  const { userInfo } = req.body;
 
  console.log('쿠로미', userInfo);

  const sql = `select * from TB_SOLARPLANT where MEM_ID = '${userInfo.id}'`;
  console.log(sql);
  if (!sql){
    return res.status(400).json({ error: 'SQL query is required' });
  }

  let connection;
  try {
    const connection = await connectToOracle();
    console.log("success"); // 연결 성공 시 "success" 출력
    const result = await connection.execute(sql);
    const ans = result.rows;
    console.log("신뇽 ans의 값은 : ", ans);

    let solarplant = {
            plant_idx : [],
            mem_id : [],
            plant_name : [],
            plant_addr : [],
            plant_power : [],
            place : [],
            sb_type : [],
            b_state : []
        }

    for(let i=0;i<result.rows.length;i++){
      solarplant.plant_idx.push(ans[i][0]);
      solarplant.mem_id.push(ans[i][1]);
      solarplant.plant_name.push(ans[i][2]);
      solarplant.plant_addr.push(ans[i][3]);
      solarplant.plant_power.push(ans[i][4]);
      solarplant.place.push(ans[i][5]);
      solarplant.sb_type.push(ans[i][6]);
      solarplant.b_state.push(ans[i][7]);
    }
      console.log("망나뇽 solarplant: ", solarplant);
      res.json(solarplant);
    
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
module.exports = solarplantrou;