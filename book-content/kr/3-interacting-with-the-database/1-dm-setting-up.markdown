#DataMapper 세팅

* This will become a table of contents (this text will be scraped).
{:toc}


## DataMapper 세팅 설정
데이터베이스 세팅 설정은 config/database.yml에 있습니다.

만약 모든 개발환경(development, test, production)에 대해서 sqlite3를 사용하신다면, 아무것도 변경하실 필요가 없으며 다음 장으로 가셔도 됩니다.

### 모든 환경이 MySQL일 경우
만약 모든 환경이 MySQL이라면 다음과 같이 된 부분을:

    development: &defaults
      # These are the settings for repository :default
      adapter:  sqlite3
      database: sample_development.db
이것으로 바꿔주시면 됩니다.

    development: &defaults
      adapter: mysql
      database: app_name_development
      username: user
      password: pass
      host: localhost

mysql이 유저네임만 인식하다면, 적용시 어답터와 호스트부분 줄만 원하시는데로 바꾸면 되겠습니다.

### Production에서만 MySQL을 사용할 경우
만약 production에서만 MySQL을 사용하시겠다면 개발환경부분은 그대로 두시고 다음의 부분을,

    production:
      <<:       *defaults
      database: production.db
      
이것으로 바꿔주시면 됩니다.

    production:
      adapter: mysql
      database: app_name_development
      username: user
      password: pass
      host: localhost
#### NOTE
MySQL과 SQLite는 약간 차이가 있습니다. 
SQLite에서는 아무 이상없지만, MySQL에서 특정 타입이 제대로 설정되지 않으면 에러를 발생시키는 경우가 있습니다.
그러므로 배치를 하기전에 모든 필드들이 이상이 없는지 테스트를 해보시기 바랍니다.

TODO Talk about setting up other DBs. 