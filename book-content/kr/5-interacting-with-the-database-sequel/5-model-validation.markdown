#모델 유효성 검증

Sequel::Model은 기본으로 검증 메소드 세트를 제공합니다.
사용가능한 표준 검증 메소드들은 다음과 같습니다:

 - acceptance\_of
 - confirmation\_of
 - format\_of
 - length\_of
 - numericality\_of
 - presence\_of
 - uniqueness\_of
  
검증은 한 클래스안에서 2가지 방법으로 기술 할 수 있습니다.

    class User < Sequel::Model
    
      validates_confirmation_of :password
      validates_length_of :login, :minimum => 5
      
      # or
      
      validates do
        confirmation_of :password
        length_of :login, :minimum => 5
      end
    end

검증이 실패할 경우 Sequel::Model은 기본으로 에러를 발생할 것입니다.
클래서 접근자(accessor) `:raise_on_save_failure`를 false로 설정하여 검증시 일어나는 에러를 피할 수 있습니다.
만약 `raise_on_save_falure`가 false라면, `#save` 메소드는 실패에 대해 false를 반환할 것입니다.

Sequel::Model와 ActiveRecord간의 중요한 차이점은 `#save!`메소드 입니다.
Sequel::Model에서 `#save!`는 검증절차 없이 레코드를 업데이트해버립니다.
ActiveRecord의 경우 업데이트시 검증이 실패하면 바로 에러를 발생시키는 것이 다른 점입니다.

만약 검증이 실패하면, 해당 객체에 `#errors` 메소드를 통한 에러 접근이 가능합니다.
    
    User.raise_on_save_faliure = false
    u = User.new(:login => 3)
    
    u.save
    => false
    u.errors.on(:login)
    => 'is too short'

[Merb::Sequel documentation][]에서 모델 검증에 대한 풀셋의 문서를 보실 수 있습니다.   

    
[Merb::Sequel documentation]: http://sequel.rubyforge.org/rdoc/classes/Sequel/Model.html