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

## 2. Continuous Deployment

> 순서도
>
> 1. 개발 진행
> 2. github push 또는 pr merge에 따라 runner 실행(적절한 방식을 runner의 트리거로 설정한다.)
> 3. runner server(github 또는 self-hosted)에서 runner 실행
>    - container (image)registry 로그인
>    - 컨테이너 이미지 빌드, 레지스트리에 push
>    - 배포서버에 ssh 접속하여 이미지 pull, 컨테이너 재시작

self-hosted로 선택한 이유는 뭐 비용이나 자유롭고싶은 마음(?)도 있지만, 배포 서버의 ssh 접속을 루트를 최소화
하기 위한 것이다. 물론 깃허브에 무슨 일이 벌어지겠냐마는, 위험한 일은 정해진 시스템에 모두 일임하는게
단순해서 좋다.
