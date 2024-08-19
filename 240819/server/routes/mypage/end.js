// 1. '/bstate' : 마이페이지에서 모집 마감 버튼 상태 띄우기
// 2. 모집마감 버튼 누르면 상태가 바뀌도록!
// 3. '/mypagerecruit' : 마이페이지 모집글 더보기
// 4. '/mypagewait' : 마이페이지에서 승인 대기 -> 승인 완료 버튼

const express = require('express');
const mypagerou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 1. '/bstate' : 마이페이지에서 모집 마감 버튼 상태 띄우기
mypagerou.post('/bstate', async (req, res) => {
    const { userInfo } = req.body;

    const id = userInfo.id;
    console.log(id);
    const sql =`select * from TB_SOLAR_BOARD where MEM_ID = '${id}'`;
    if (!sql) {
        return res.status(400).json({ error: 'SQL query is required' });
      }
    
      let connection;
      try {
        const connection = await connectToOracle();
        // console.log("success"); // 연결 성공 시 "success" 출력
        const result = await connection.execute(sql);
        // console.log('리자몽', result);
        const ans = result.rows;
        let solar_board = {
          sb_idx : [],
          sb_type : [],
          plant_power_sum : [],
          mem_id : [],
          place : [],
          b_state : [],
      }
        // console.log("ans의 값은 : ", ans)
        for(let i=0;i<result.rows.length;i++){
          solar_board.sb_idx.push(ans[i][0]);
          solar_board.sb_type.push(ans[i][1]);
          solar_board.plant_power_sum.push(ans[i][2]);
          solar_board.mem_id.push(ans[i][3]);
          solar_board.place.push(ans[i][4]);
          solar_board.b_state.push(ans[i][5]);
        }
        console.log("마이페이지 모집 마감 solar_board: ", solar_board);
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

// 2. 모집마감 버튼 누르면 상태가 바뀌도록!
mypagerou.post('/bchange', async (req, res) => {
  const { userInfo } = req.body;
  console.log('모집 마감 버튼', userInfo);
  
  const id = userInfo.id;
  console.log(id);

  const sql =`update TB_SOLAR_BOARD set B_state = 'end' where MEM_ID = '${id}'`;
  if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      // console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      console.log("모집마감 버튼 결과 : ", result.rowsAffected);

        if (result.rowsAffected && result.rowsAffected > 0) {
            res.json('success');
            
        }else {
            console.log('모집마감 변경 실패');

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

// 3. '/mypagerecruit' : 마이페이지 모집글 더보기
mypagerou.post('/mypagerecruit', async (req, res) => {
  const { userInfo } = req.body;
  console.log('마이페이지 모집게시글 더보기 버튼', userInfo);

  const id = userInfo.id;
  console.log('마릴', id);

  const sql =`select SB_IDX from TB_SOLAR_BOARD where MEM_ID = '${id}'`;
  if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      // console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      console.log(" 토게피", result.rows);

        if (result.rows.length > 0) {
            res.json(`${result.rows}`);
            
        }else {
            console.log('모집마감 변경 실패');

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

// 4. '/mypagewait' : 마이페이지에서 승인 대기 -> 승인 완료 버튼
mypagerou.post('/mypagewait', async (req, res) => {
  const { idx, userInfo } = req.body;

  console.log('마이페이지 승인 완료 버튼', idx);
  console.log('마이페이지 승인 완료 버튼', userInfo);

  const id = userInfo.id;
  console.log('웅이' + id);

  const sql = `select *
                from TB_SOLARPLANT
                where MEM_ID in (select MEM_ID 
                                from TB_SOLAR_COMMENT 
                                where SB_IDX = (select SB_IDX from TB_SOLAR_BOARD where MEM_ID = '${id}'))`;
  
  
  console.log('미뇽', sql);
  if (!sql) {
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

    const sql2 = `update TB_SOLARPLANT set B_STATE = 'complete' where MEM_ID = '${solarplant.mem_id[idx-1]}'`
    if (!sql2) {
      return res.status(400).json({ error: 'SQL query is required' });
    }

    console.log('피츄', sql2);
    const result2 = await connection.execute(sql2);
    console.log('피카츄', result2.rowsAffected);
    
    if (result2.rowsAffected > 0) {
      res.json('success');
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


module.exports = mypagerou;