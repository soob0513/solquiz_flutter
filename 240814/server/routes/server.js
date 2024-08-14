const express = require('express');
const cors = require('cors');
const path = require('path');
const axios = require('axios');
const qs = require('qs');
const app = express();
const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || '0.0.0.0';

const connectToOracle = require('../config/dbConn'); // dbConn.js에서 getConnection 함수 가져오기

app.use(cors());
app.use(express.json());

// 'routes/apiRoutes.js'에서 라우팅 설정을 불러옵니다.
const boardsql =
 require('./board/boardsql')
// '/boardsql' 경로로 오는 모든 요청을 boardsql로 전달합니다.
app.use('/boardsql', boardsql);

// 모집게시판
const recruitsql =
 require('./recruit/recruitsql')
app.use('/recruitsql', recruitsql);

// 로그인
const login = require('./member/login')
app.use('/login', login);

// 회원가입
const join = require('./member/join')
app.use('/join', join);

// 발전소 등록
const solarplant = require('./solarplant/solarplant')
app.use('/solarplant', solarplant);

// 발전소 등록
const predsql = require('./pred/preddb')
app.use('/predsql', predsql);



// 데이터베이스 연결 테스트
(async () => { 
  try {
    const connection = await connectToOracle();
    console.log("success"); // 연결 성공 시 "success" 출력
    //await connection.close(); // 연결 종료 (풀로 반환)
    const result = await connection.execute(
      `SELECT * FROM TB_TEST`
      // a 컬럼 데이터 조회 쿼리
    );

    const data = result.rows.map(row => row[0]); // 결과 데이터 추출
    await connection.close(); // 연결 종료

    console.log(data) // 결과 데이터 JSON 형태로 응답
  } catch (err) {
    console.error("Error connecting to Oracle:", err);
  }
})();

// 테스트용
// SQL 쿼리 실행 엔드포인트
app.post('/query', async (req, res) => {
  const { sql } = req.body;

  if (!sql) {
    return res.status(400).json({ error: 'SQL query is required' });
  }

  let connection;
  try {
    connection = await connectToOracle();
    const result = await connection.execute(sql);
    console.log(result.rows)
    res.json({
      'id': result.rows[0][0],
      'name': result.rows[0][2],
      'phone' : result.rows[0][3],
      'joined_at' : result.rows[0][5],
      'user_type' : result.rows[0][6],
      'email': result.rows[0][4],
    });
    console.log(result.rows[0][0])
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

// 플러터 API 엔드포인트 추가
app.post('/dbtest', async (req, res) => {
  const query = req.body.query;
  console.log(query);
  
  try {
    const connection = await connectToOracle();
    const result = await connection.execute(query);

    const data = result.rows.map(row => {
      let rowData = {};
      for (let i = 0; i < result.metaData.length; i++) {
        rowData[result.metaData[i].name] = row[i];
      }
      console.log(rowData)
      return rowData;
    });

    await connection.close(); // 연결 종료

    res.json({
      success: true,
      message: 'Query executed successfully',
      data: data // 변환된 데이터 전송
    });
      
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message 
    });
  }
});



app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}`);
});
