# getting-started

 <ul class='toc'>
<li><a href='/kr/getting-started/instructions'>설치 방법</a>
<ul style='list-style: none;'><li><a href='/kr/getting-started/instructions#os_x'>OS X</a>
	<ul style='list-style: none;'><li><a href='/kr/getting-started/instructions#osx_prerequisites'>필요 조건</a></li>
	<li><a href='/kr/getting-started/instructions#osx_rubygems'>Ruby &amp; RubyGems</a></li>
	<li><a href='/kr/getting-started/instructions#osx_merb'>Merb</a></li>
	</ul>
</li>
<li><a href='/kr/getting-started/instructions#linux'>Linux</a><ul style='list-style: none;'><li><a href='/kr/getting-started/instructions#linux_prerequisites'>필요 조건</a></li><li><a href='/kr/getting-started/instructions#linux_rubygems'>Ruby &amp; RubyGems</a></li>
<li><a href='/kr/getting-started/instructions#linux_merb'>Merb</a></li></ul></li><li><a href='/kr/getting-started/instructions#windows'>Windows</a></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/application'>어플리케이션 생성하기</a>
<ul style='list-style: none;'><li><a href='/kr/getting-started/application#types'>타입들</a>
<ul style='list-style: none;'>
	<li><a href='/kr/getting-started/application#app'>App</a></li>
	<li><a href='/kr/getting-started/application#core'>Core</a></li>
	<li><a href='/kr/getting-started/application#flat'>Flat</a></li>
	<li><a href='/kr/getting-started/application#very_flat'>Very Flat</a></li>
</ul></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/structure'>프로젝트 구조</a><ul style='list-style: none;'><li><a href='/kr/getting-started/structure#app'>app</a><ul style='list-style: none;'><li><a href='/kr/getting-started/structure#controllers'>controllers</a></li><li><a href='/kr/getting-started/structure#models'>models</a></li><li><a href='/kr/getting-started/structure#views'>views</a></li></ul></li><li><a href='/kr/getting-started/structure#config'>config</a><ul style='list-style: none;'><li><a href='/kr/getting-started/structure#environments'>environments</a></li></ul></li><li><a href='/kr/getting-started/structure#gems'>gems</a></li><li><a href='/kr/getting-started/structure#public'>public</a><ul style='list-style: none;'><li><a href='/kr/getting-started/structure#images'>images</a></li><li><a href='/kr/getting-started/structure#javascripts'>javascripts</a></li><li><a href='/kr/getting-started/structure#stylesheets'>stylesheets</a></li></ul></li><li><a href='/kr/getting-started/structure#spec'>spec</a></li><li><a href='/kr/getting-started/structure#tasks'>tasks</a></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/mvc'>MVC</a></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/controllers'>컨트롤러</a><ul style='list-style: none;'>
<li><a href='/kr/getting-started/controllers#generating_controllers'>컨트롤러 생성하기</a>
<ul style='list-style: none;'><li><a href='/kr/getting-started/controllers#a_standard_controller'>표준 컨트롤러</a></li><li><a href='/kr/getting-started/controllers#a_restful_controller'>REStful 컨트롤러</a></li></ul></li><li>
<a href='/kr/getting-started/controllers#rest'><abbr title='Representational state transfer'>REST</abbr></a><ul style='list-style: none;'><li><a href='/kr/getting-started/controllers#the_default_routing_style'>기본 라우팅 스타일</a></li>
<li><a href='/kr/getting-started/controllers#the_restful_style'><abbr title='Representational state transfer'>REST</abbr>ful 스타일</a><ul style='list-style: none;'><li><a href='/kr/getting-started/controllers#index'>Index</a></li><li><a href='/kr/getting-started/controllers#new'>New</a></li><li><a href='/kr/getting-started/controllers#create'>Create</a></li><li><a href='/kr/getting-started/controllers#show'>Show</a></li><li><a href='/kr/getting-started/controllers#edit'>Edit</a></li><li><a href='/kr/getting-started/controllers#update'>Update</a></li><li><a href='/kr/getting-started/controllers#delete'>Delete</a></li><li><a href='/kr/getting-started/controllers#destroy'>Destroy</a></li></ul></li><li><a href='/kr/getting-started/controllers#adding_and_removing_methods'>메소드들을 추가, 삭제하기</a></li></ul></li><li><a href='/kr/getting-started/controllers#using_merbgen_with_controllers'>컨트롤러들과 함께 merb-gen 사용하기</a></li><li><a href='/kr/getting-started/controllers#controller_action_methods'>컨트롤러 액션 메소드들</a><ul style='list-style: none;'><li><a href='/kr/getting-started/controllers#render_and_display'>렌더링하고 디스플레이하기</a></li><li><a href='/kr/getting-started/controllers#interaction_with_model'>모델과의 상호작용</a></li><li><a href='/kr/getting-started/controllers#information_from_the_request_the_params_and_request_hashes'>요청에 의한 정보 : &#8216;params&#8217; 와 &#8216;request&#8217; 해시</a></li><li><a href='/kr/getting-started/controllers#persistant_information_about_the_client_sessions_and_cookies'>클라이언트에 대한 지속적인 정보 : 세션과 쿠키</a></li><li><a href='/kr/getting-started/controllers#redirecting'>리다이렉팅</a></li><li><a href='/kr/getting-started/controllers#exceptions_and_status_codes'>예외와 상태 코드들</a></li></ul></li><li><a href='/kr/getting-started/controllers#extending_controllers'>컨트롤러 확장하기</a><ul style='list-style: none;'><li><a href='/kr/getting-started/controllers#formats'>포멧들</a></li><li><a href='/kr/getting-started/controllers#before_and_after_filters'>Before와 After 필터들</a></li><li><a href='/kr/getting-started/controllers#use_of_application'>&#8216;Application&#8217;의 사용</a></li><li><a href='/kr/getting-started/controllers#private_methods'>프라이빗 메소드들</a></li></ul></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/views'>뷰</a><ul style='list-style: none;'><li><a href='/kr/getting-started/views#form_helpers'>폼 헬퍼</a></li><li><a href='/kr/getting-started/views#date_and_time_helpers'>시간과 날짜 헬퍼</a></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/models'>모델</a><ul style='list-style: none;'><li><a href='/kr/getting-started/models#attributes'>어트리뷰트</a></li><li><a href='/kr/getting-started/models#validations'>검증</a></li><li><a href='/kr/getting-started/models#associations'>어쏘시에이션</a></li><li><a href='/kr/getting-started/models#callbacks'>콜백</a></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/path'>요청 경로</a><ul style='list-style: none;'><li><a href='/kr/getting-started/path#from_the_client_to_our_doorstep'>클라이언트로부터 문앞까지</a></li><li><a href='/kr/getting-started/path#reverse_proxy_optional'>리버스 프록시(optional)</a></li><li><a href='/kr/getting-started/path#web_server'>웹서버</a></li><li><a href='/kr/getting-started/path#rack_and_merb'>Rack과 Merb</a></li><li><a href='/kr/getting-started/path#router'>라우터</a></li><li><a href='/kr/getting-started/path#controller_action'>컨트롤러 액션</a></li><li><a href='/kr/getting-started/path#out_the_door'>문 밖</a></li><li><a href='/kr/getting-started/path#caching'>캐싱</a></li></ul></li></ul>

<ul class='toc'><li><a href='/kr/getting-started/router'>라우터</a></li></ul> 
