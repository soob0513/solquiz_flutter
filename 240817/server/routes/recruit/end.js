// 마이페이지에서 모집 마감 버튼을 누른다면 
const express = require('express');
const bstaterou = express.Router();

const connectToOracle = require('../../config/dbConn');

bstaterou.post('/bstate', async (req, res) => {
    const { userInfo } = req.body;
    console.log('모집 마감 버튼', userInfo);
    
    const id = userInfo.id;
    console.log(id);
    const sql =`select * from TB_SOLAR_COMMENT where MEM_ID = '${id}'`;
    if (!sql) {
        return res.status(400).json({ error: 'SQL query is required' });
      }
    
      let connection;
      try {
        const connection = await connectToOracle();
        // console.log("success"); // 연결 성공 시 "success" 출력
        const result = await connection.execute(sql);
        console.log('리자몽',result);
        const ans = result.rows;
        let solarplant = {
                sp_idx : [],
                sb_idx : [],
                mem_id : [],
                sp_sta : [],
        }
        // console.log("ans의 값은 : ", ans)
        for(let i=0;i<result.rows.length;i++){
          solarplant.sp_idx.push(ans[i][0]);
          solarplant.sb_idx.push(ans[i][1]);
          solarplant.mem_id.push(ans[i][2]);
          solarplant.sp_sta.push(ans[i][3]);
        }
        console.log('모집마감 버튼 : ', solarplant);
        
        if (result.rows.length > 0) {
            res.json(solarplant);
            
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

module.exports = bstaterou;