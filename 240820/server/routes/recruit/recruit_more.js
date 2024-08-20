// 1. '/recruitmore' : 모집 게시판 상세 페이지
// 2. '/myrecruit' : 마이페이지 모집현황 띄우기
// 3. '/participate' : 모집 게시판 상세 페이지 참여하기 버튼 활성화

const express = require('express');
const recruitmorerou = express.Router();

const connectToOracle = require('../../config/dbConn');

// 1. '/recruitmore' : 모집 게시판 상세 페이지
recruitmorerou.post('/recruitmore', async (req, res) => {
  const { idx } = req.body;
  console.log('모집 게시판 상세 페이지', idx);

  const sql = `select PLANT_POWER, PLACE, SB_TYPE, B_STATE from TB_SOLARPLANT where MEM_ID in (select MEM_ID from TB_SOLAR_COMMENT where SB_IDX = ${parseInt(idx) +1})`
  // console.log(sql);
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
            sb_type : [],
            b_state : []
        }
    // console.log("ans의 값은 : ", ans)
    for(let i=0;i<result.rows.length;i++){
      solar_board.plant_power.push(ans[i][0]);
      solar_board.place.push(ans[i][1]);
      solar_board.sb_type.push(ans[i][2]);
      solar_board.b_state.push(ans[i][3]);
    }
    // console.log("solar_board: ", solar_board);
    res.json(solar_board);

    

    // 연결 해제 null
    await connection.close();
  } catch (error) {
    console.error('SQL error:', error);
    res.status(500).json({ error: 'Failed to execute query', details: error.message});
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

  // 2. '/myrecruit' : 마이페이지 모집현황 띄우기
  recruitmorerou.post('/myrecruit', async (req, res) => {
    const { userInfo } = req.body;
    console.log('마이페이지 모집현황 띄우기', userInfo);
    // const id = userInfo.id;

    const sql = `select PLANT_POWER, PLACE, SB_TYPE, B_STATE 
                                  from TB_SOLARPLANT
                                  where MEM_ID in (select MEM_ID
                                                    from TB_SOLAR_COMMENT
                                                    where SB_IDX = (select SB_IDX
                                                                    from TB_SOLAR_BOARD
                                                                    where MEM_ID = '${userInfo.id}'))`;
                                  
    
    console.log('미뇽', sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
    
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      // console.log('신뇽', result);
      const ans = result.rows;
      
      let solar_board = {
              plant_power : [],
              place : [],
              sb_type : [],
              b_state : []
          }
      console.log("ans의 값은 : ", ans);
      for(let i=0;i<result.rows.length;i++){
        solar_board.plant_power.push(ans[i][0]);
        solar_board.place.push(ans[i][1]);
        solar_board.sb_type.push(ans[i][2]);
        solar_board.b_state.push(ans[i][3]);
      }
      console.log("꼬부기 solar_board: ", solar_board);
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

  // 3. '/participate' : 모집 게시판 상세 페이지 참여하기 버튼 활성화
  recruitmorerou.post('/participate', async (req, res) => {
    const { userInfo } = req.body;
    console.log('엔믹스', userInfo);

    // const id = userInfo.id;
    
    const sql = `select * from TB_SOLAR_COMMENT where MEM_ID = '${userInfo.id}'`
    console.log(sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      console.log('레드벨벳', result.rows);
      
      if (result.rows.length > 0) {
        const ans = result.rows;
      
      let solar_board = {
              sp_idx : [],
              sb_idx : [],
              mem_id : [],
              sp_sta : []
          }
      console.log("ans의 값은 : ", ans);
      for(let i=0;i<result.rows.length;i++){
        solar_board.sp_idx.push(ans[i][0]);
        solar_board.sb_idx.push(ans[i][1]);
        solar_board.mem_id.push(ans[i][2]);
        solar_board.sp_sta.push(ans[i][3]);
      }
      console.log("꼬부기 solar_board: ", solar_board);
      res.json(solar_board);
        
      }else {
        res.json(solar_board = {
          sp_idx : [],
          sb_idx : [],
          mem_id : [],
          sp_sta : []
      });
      }

    // 연결 해제 null
    await connection.close();
  } catch (error) {
    console.error('SQL error:', error);
    res.status(500).json({ error: 'Failed to execute query', details: error.message});
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

  // 4. '/participateadd' : 모집 게시판 상세 페이지 참여하기 버튼 활성화
  recruitmorerou.post('/participateadd', async (req, res) => {
    const { idx, userInfo } = req.body;
    console.log('블래키', idx);
    console.log('이브이', userInfo);

    const id = userInfo.id;
    // MAX(SB_IDX)+1
    const sql = `insert into TB_SOLAR_COMMENT values (SEQ_COMMENT_IDX.NEXTVAL, ${parseInt(idx) +1}, '${id}', 'wait')`
    console.log(sql);
    if (!sql) {
      return res.status(400).json({ error: 'SQL query is required' });
    }
  
    let connection;
    try {
      const connection = await connectToOracle();
      console.log("success"); // 연결 성공 시 "success" 출력
      const result = await connection.execute(sql);
      console.log('블랙핑크', result);
      
      if (result.rowsAffected && result.rowsAffected > 0) {
        res.json('success');
        
      }else {
        console.log('회원가입 실패');
        res.json('failed');
      }
    // 연결 해제 null
    await connection.close();
  } catch (error) {
    console.error('SQL error:', error);
    res.status(500).json({ error: 'Failed to execute query', details: error.message});
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