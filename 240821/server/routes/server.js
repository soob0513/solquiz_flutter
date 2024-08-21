const express = require('express');
const cors = require('cors');
const path = require('path');
const axios = require('axios');
const qs = require('qs');
const app = express();
const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || '192.168.219.54';

const connectToOracle = require('../config/dbConn'); // dbConn.js에서 getConnection 함수 가져오기

app.use(cors());
app.use(express.json());

// 'routes/apiRoutes.js'에서 라우팅 설정을 불러옵니다.
const boardsql = require('./board/boardsql');
// '/boardsql' 경로로 오는 모든 요청을 boardsql로 전달합니다.
app.use('/boardsql', boardsql);

// 모집게시판
const recruitsql =
 require('./recruit/recruitsql');
app.use('/recruitsql', recruitsql);

// 로그인
const login = require('./member/login');
app.use('/login', login);

// 회원가입
const join = require('./member/join');
app.use('/join', join);

// 발전소 등록
const solarplant = require('./solarplant/solarplant');
app.use('/solarplant', solarplant);

// 발전소 
const predsql = require('./pred/preddb');
app.use('/predsql', predsql);

// 모집 게시판 상세 페이지
const recruitmore = require('./recruit/recruit_more');
app.use('/recruit', recruitmore);

// rec,smp 조회
const smprecsql = require('./smprec/smprec');
app.use('/smprecsql', smprecsql);

// 마이페이지에서 모집 마감 버튼을 누른다면
const mypage = require('./mypage/end');
app.use('/mypage', mypage);

// 카카오
const kakaosql = require('./kakao/kakao')
app.use('/kakaosql', kakaosql);


app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}`);
});
