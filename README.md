# 이 프로젝트는

정적 사이트의 continuous deployment를 위한 스터디용 프로젝트다.

소스코드는 git으로 관리하되, github의 main 브랜치에 push되면 github action을 실행한다. 이 action이 하는
일은 다음과 같다.

1. docker image를 빌드
2. 나의 registry(여기서는 docker hub)에 push
3. server 시스템에 ssh 접속하여 새롭게 빌드된 최신 이미지를 pull
4. 사용자 끊김 없이 무중단 배포

이를 위해 docker, github action, github secrets과 같은 도구를 활용한다. 웹서버는 nginx로 가자.

## 1. 프로젝트 세팅

프로젝트 세팅은 vite의 [공식문서에서도 권장](https://ko.vitejs.dev/guide/#community-templates)하는 커뮤니티 템플릿 중 react-ts를 사용했다.

`pnpm create vite my-app --template react-ts`

ref: [npm create-vite](https://www.npmjs.com/package/create-vite)
