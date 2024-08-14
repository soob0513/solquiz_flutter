// routes/apiRoutes.js
// TB_SOLARPLANT
const express = require('express');
const solarplantrou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 게시판 조회 함수
solarplantrou.post('/sp', async (req, res) => {
   const { id, plant_name, plant_addr, plant_power } = req.body;
   console.log('발전소 등록 페이지 ', id, plant_name, plant_addr, plant_power);
//    console.log('마이페이지 storage 넘겨받기 : ', userInfo);

//    const id = userInfo.id;
//    const pw = userInfo.pw;

//     const sql = `select * from TB_MEMBER where MEM_ID = '${id}' AND MEM_PW = '${pw}'`;
//     // console.log(sql);
//     if (!sql) {
//       return res.status(400).json({ error: 'SQL query is required' });
//     }
    
//     let connection;
//     try {
//       const connection = await connectToOracle();
//       console.log("success"); // 연결 성공 시 "success" 출력
      
//       const result = await connection.execute(sql);
//       const ans = result.rows
//       let solarplant = {
//               plant_id : [],
//               mem_id : [],
//               plant_name : [],
//               plant_addr : [],
//               plant_power : [],
//               place : [],
//               sb_type : [],

//           }
//       console.log("발전소 등록 ans : ", ans);
//       for(let i=0;i<result.rows.length;i++){
//         solarplant.plant_id.push(ans[i][0]);
//         solarplant.mem_id.push(ans[i][1]);
//         solarplant.plant_name.push(ans[i][2]);
//         solarplant.plant_addr.push(ans[i][3]);
//         solarplant.plant_power.push(ans[i][4]);
//         solarplant.place.push(ans[i][5]);
//         solarplant.sb_type.push(ans[i][6]);
//       }
//       console.log("발전소 등록 solarplant: ", solarplant);
//       res.json(solarplant);

//       // 연결 해제 null
//       await connection.close();
//     } catch (error) {
//       console.error('SQL error:', error);
//       res.status(500).json({ error: 'Failed to execute query', details: error.message });
//     } finally {
//       if (connection) {
//         try {
//           await connection.close();
//         } catch (err) {
//           console.error('Error closing connection:', err);
//         }
//       }
//     }
    
  });


  // 라우터를 모듈로 내보냅니다.
module.exports = solarplantrou;