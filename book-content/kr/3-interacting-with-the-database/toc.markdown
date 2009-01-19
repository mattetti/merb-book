# 데이터베이스와 상호작용

<ul class='toc'><li><a href='/kr/interacting-with-the-database/up'>DataMapper 세팅</a>
	<ul style='list-style: none;'>
		<li><a href='/kr/interacting-with-the-database/up#DataMapper_세팅_설정'>DataMapper 세팅 설정</a>
		<ul style='list-style: none;'>
		<li><a href='/kr/interacting-with-the-database/up#모든_환경이_MySQL일 경우'>모든 환경이 MySQL일 경우</a></li>
		<li><a href='/kr/interacting-with-the-database/up#Production에서만_MySQL을_사용할_경우'>Production에서만 MySQL을 사용할 경우</a>
			<ul style='list-style: none;'>
			<li><a href='/kr/interacting-with-the-database/up#note'>NOTE</a></li>
			</ul>
	</li></ul>
	</li></ul>
</li></ul>

<ul class='toc'><li><a href='/kr/interacting-with-the-database/schema'>데이터베이스 스키마</a>
	<ul style='list-style: none;'>
		<li><a href='/kr/interacting-with-the-database/schema#모델'>모델</a>
		<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/schema#모델_생성'>모델 생성</a></li>
		<li><a href='/kr/interacting-with-the-database/schema#모델_열어보기'>모델 열어보기</a></li>
		<li><a href='/kr/interacting-with-the-database/schema#속성_정의'>속성 정의</a></li>
		<li><a href='/kr/interacting-with-the-database/schema#가질_수_있는_타입들'>가질 수 있는 타입들:</a></li>
	<li><a href='/kr/interacting-with-the-database/schema#마이그레이트'>마이그레이트</a></li></ul></li>
</ul></li>
</ul>
	
<ul class='toc'><li><a href='/kr/interacting-with-the-database/queries'>데이터베이스 쿼리</a>
	<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/queries#생성'>생성</a>
	<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/queries#new'>New</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#속성들_설정'>속성들 설정</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#저장하기'>저장하기</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#유효성_검증_결과'>유효성 검증 결과</a>
	<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/queries#에러'>에러</a></li>
	</ul></li></ul></li>
	<li><a href='/kr/interacting-with-the-database/queries#데이터_읽기'>데이터 읽기</a><ul style='list-style: none;'>
	<li><a href='/kr/interacting-with-the-database/queries#한개의_데이터_읽기'>한개의 데이터 읽기</a><ul style='list-style: none;'>
	<li><a href='/kr/interacting-with-the-database/queries#프라이머리_키에_의한_방법'>프라이머리 키에 의한 방법</a>
	<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/queries#serial'>Serial</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#string'>String</a></li></ul></li></ul></li>
	<li><a href='/kr/interacting-with-the-database/queries#속성(들)에_의한_방법'>속성(들)에 의한 방법</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#여러개의_데이터_얻기'>여러개의 데이터 얻기</a></li>
	</ul></li><li><a href='/kr/interacting-with-the-database/queries#업데이트'>업데이트</a>
	<ul style='list-style: none;'>
	<li><a href='/kr/interacting-with-the-database/queries#먼저_속성들을_변경한_후_업데이트하는_방법'>먼저 속성들을 변경한 후, 업데이트하는 방법</a>
	<ul style='list-style: none;'><li><a href='/kr/interacting-with-the-database/queries#속성들_변경하기'>속성들 변경하기</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#업데이트'>업데이트</a></li></ul></li>
	<li><a href='/kr/interacting-with-the-database/queries#속성들_변경과_업데이트를_한번에_하기'>속성들 변경과 업데이트를 한번에 하기</a></li>
	<li><a href='/kr/interacting-with-the-database/queries#dirtiness'>Dirtiness</a></li></ul></li>
	<li><a href='/kr/interacting-with-the-database/queries#삭제하기'>삭제하기</a></li></ul>
</li></ul>



<ul class='toc'><li><a href='/kr/interacting-with-the-database/relationships'>모델 관계</a></li></ul>

<ul class='toc'><li><a href='/kr/interacting-with-the-database/migrations'>데이터베이스 마이그레이션</a>
<ul style='list-style: none;'>
<li><a href='/kr/interacting-with-the-database/migrations#DB생성과_셋업'>DB생성과 셋업</a></li>
<li><a href='/kr/interacting-with-the-database/migrations#나중에_변경하게_될 때'>나중에 변경하게 될 때</a>
<ul style='list-style: none;'><li>
<a href='/kr/interacting-with-the-database/migrations#주의사항'>주의사항</a></li>
<li><a href='/kr/interacting-with-the-database/migrations#기본_값'>기본 값</a></li>
<li><a href='/kr/interacting-with-the-database/migrations#dmmigrations'>DM-Migrations</a></li></ul>
</li></ul></li></ul>

<ul class='toc'><li><a href='/kr/interacting-with-the-database/validations'>유효성 검증</a></li></ul> 
