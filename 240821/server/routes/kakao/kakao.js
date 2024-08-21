const express = require('express');
const kakaorou = express.Router();
const axios = require('axios');
const queryString = require('querystring');
require('dotenv').config();
const KAKAO_REST_API_KEY = process.env.KAKAO_REST_API_KEY;
const KAKAO_REDIRECT_URL = process.env.KAKAO_REDIRECT_URL;
const KAKAO_SERVICE_APP_ADMIN_KEY = process.env.KAKAO_SERVICE_APP_ADMIN_KEY;
const KAKAO_CLIENT_SECRET_KEY = process.env.KAKAO_CLIENT_SECRET_KEY;


kakaorou.get('/auth/kakao', (req, res) => {
    console.log("카카오 로그인 정보 전송1");
    const kakaoAuthUrl = `https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${KAKAO_REST_API_KEY}&redirect_uri=${KAKAO_REDIRECT_URL}`;
    res.redirect(kakaoAuthUrl);
    console.log(KAKAO_REST_API_KEY);
    console.log("카카오 로그인 정보 전송2");
  });
  
kakaorou.get('/auth/kakao/callback', async (req, res) => {
    console.log("카카오에서 나한테 정보 줌 ㅋㅋ");
    const { code } = req.query;
    const tokenUrl = 'https://kauth.kakao.com/oauth/token';
    const userUrl = 'https://kapi.kakao.com/v2/user/me';

    function formatDateString(isoDateString) {
        const date = new Date(isoDateString);
    
        const year = date.getUTCFullYear();
        const month = String(date.getUTCMonth() + 1).padStart(2, '0');
        const day = String(date.getUTCDate()).padStart(2, '0');
        const hour = String(date.getUTCHours()).padStart(2, '0');
        const minute = String(date.getUTCMinutes()).padStart(2, '0');
    
        return `${year}-${month}-${day} ${hour}:${minute}`;
    }
    try {
        const tokenResponse = await axios.post(tokenUrl, queryString.stringify({
        grant_type: 'authorization_code',
        client_id: KAKAO_REST_API_KEY,
        redirect_uri: KAKAO_REDIRECT_URL,
        code,
        client_secret: KAKAO_CLIENT_SECRET_KEY,
        }));

        const { access_token } = tokenResponse.data;

        const userResponse = await axios.get(userUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
        });

        const userId = userResponse.data.id;
        const usernick = userResponse.data.properties.nickname;
        const useremail = userResponse.data.kakao_account.email;
        const userdate = formatDateString(userResponse.data.connected_at);
        console.log("1:",userResponse.data.id);
        console.log("2:",userResponse.data.connected_at);
        console.log("3:",userResponse.data.properties.nickname);
        console.log("4:",userResponse.data.kakao_account.email);
        // 사용자 ID와 상태를 Flutter로 전달
        res.send(`<script>window.location = 'james://${userId}~${useremail}+200+';</script>`);
    } catch (error) {
        console.error(error);
        res.send(`<script>window.location = 'james://error';</script>`);

    }
});

// kakaorou.post('/kakao', (req,res) => {
//   console.log("카카오 로그인 시도");
//   console.log("카카오 키 1 : ",KAKAO_REST_API_KEY);
//   console.log("카카오 키 2 : ",KAKAO_REDIRECT_URL);
//   const kakaoAuthURL = `https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${KAKAO_REST_API_KEY}&redirect_uri=${KAKAO_REDIRECT_URL}`;
//   res.redirect(kakaoAuthURL);
//   console.log("카카오로 정보 전송 완료");

// });

// /* login 이후 나타나는 callback page */
// kakaorou.get("/auth/kakao/callback", async (req, res) => {
//     const { code } = req.query;
//     const tokenUrl = 'https://kauth.kakao.com/oauth/token';
//     const userUrl = 'https://kapi.kakao.com/v2/user/me';

//     try {
//         const tokenResponse = await axios.post(tokenUrl, queryString.stringify({
//         grant_type: 'authorization_code',
//         client_id: KAKAO_REST_API_KEY,
//         redirect_uri: KAKAO_REDIRECT_URL,
//         code,
//         client_secret: KAKAO_CLIENT_SECRET_KEY,
//         }));

//         const { access_token } = tokenResponse.data;

//         const userResponse = await axios.get(userUrl, {
//         headers: { Authorization: `Bearer ${access_token}` },
//         });

//         const userId = userResponse.data.id;

//         // 사용자 ID와 상태를 Flutter로 전달
//         res.send(`<script>window.location = 'james://${userId}-200';</script>`);
//     } catch (error) {
//         console.error(error);
//         res.send(`<script>window.location = 'james://error';</script>`);
//     }
// })

// kakaorou.get('/kakao/redirect' , async (req , res)=>{
//     const {code} = req.query;
//     const result = await kakaoTokenReq({code});
//     const userInfo = await kakaoUserReq({access_token: result.access_token});
//     const {id, userStateCode} = userValidation(userInfo);
//     const sendData = `${id}-${userStateCode}`;
//     return res.send(`
//         <!DOCTYPE html>
//         <html lang="ko">
//         <head>
//             <meta charset="UTF-8">
//             <meta name="viewport" content="width=device-width, initial-scale=1.0">
//             <title>JamesDev</title>
//         </head>
//         <body>
//             <h2>카카오 로그인 진행 중</h2>
//             <script>
//                 window.onload = _ => {
//                     james.postMessage("${sendData}");
//                 }
//             </script>
//         </body>
//         </html>
//     `);
// });




module.exports = kakaorou;