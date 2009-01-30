#데이터베이스 스키마

* This will become a table of contents (this text will be scraped).
{:toc}

## 모델

### 모델 생성
    merb-gen model ModelName

### 모델 열기

MERB_ROOT/app/models/model_name.rb 파일을 열어보시면 됩니다.

### 속성들 정의하기 

DataMapper에서는, 테이블생성이나 칼럼을 추가하기 위해 짜증스러운 마이그레이션을 하실 필요가 없습니다.
(물론 보다 고급의 일들을 처리하는데에는 필요합니다.)

기본 모델 (주석 포함): 
    
    class Person
      include DataMapper::Resource
      
      #You can change this if you want
      property :id, Serial
      
      #more properties here
      # in format: 
      #property :name, Type, :option => value, :option2 => value2
      ... 
      
    end

### 타입들
[http://datamapper.org](http://datamapper.org/)에서 참고했습니다:

* * * * *

DM-Core는 다음의 '원시(primitive)' 데이터 타입들을 지원합니다.

<ul>
<li class="level1"><div class="li"> TrueClass, Boolean</div>
</li>
<li class="level1"><div class="li"> String</div>
</li>
<li class="level1"><div class="li"> Text</div>

</li>
<li class="level1"><div class="li"> Float</div>
</li>
<li class="level1"><div class="li"> Fixnum, Integer</div>
</li>
<li class="level1"><div class="li"> BigDecimal,</div>
</li>
<li class="level1"><div class="li"> DateTime, Date, Time</div>
</li>

<li class="level1"><div class="li"> Object, (marshalled)</div>
</li>
<li class="level1"><div class="li"> Discriminator (all you need for Single Table Inheritance, actually)</div>
</li>
</ul>

만약 DM-Types을 include하시면, 다음의 데이터 타입들이 지원됩니다:

<ul>
<li class="level1"><div class="li"> Csv</div>

</li>
<li class="level1"><div class="li"> Enum</div>
</li>
<li class="level1"><div class="li"> EpochTime</div>
</li>
<li class="level1"><div class="li"> FilePath</div>
</li>
<li class="level1"><div class="li"> Flag</div>
</li>

<li class="level1"><div class="li"> IPAddress</div>
</li>
<li class="level1"><div class="li"> <acronym title="Uniform Resource Identifier">URI</acronym></div>
</li>
<li class="level1"><div class="li"> Yaml</div>
</li>
<li class="level1"><div class="li"> Json</div>
</li>
<li class="level1"><div class="li"> BCryptHash</div>

</li>
<li class="level1"><div class="li"> Regex</div>
</li>
</ul>

이 타입들에 대한 내용은 [여기](http://datamapper.org/doku.php?id=dm-more:dm-types)에서 보실 수 있습니다.

* * * * *
보다 자세한 내용은 다음의 링크에서 참조하시기 바랍니다.
More specifics on properties are found here:
[http://datamapper.org/doku.php?id=docs:properties](http://datamapper.org/doku.php?id=docs:properties)

### 마이그레이션

명백하게 말씀드리자면, 여러분은 속성들을 먼저 정의하는 것을 끝내셔야 됩니다.
그다음, 다음의 명령을 실행하시고

    rake db:create
    
이제 마이그레이트 명령을 실행하시면 됩니다.

    rake db:automigrate

이제 원하시는 것들이 생성되었을 것입니다.
보다 자세한 정보는 [마이그레이션 페이지](/interacting-with-the-database/dm-migrations)를 참고하시기 바랍니다.
