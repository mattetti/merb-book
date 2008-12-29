#Cucumber를 사용한 통합테스팅

* This will become a table of contents (this text will be scraped).
{:toc}

[Cucumber][]는 Merb 어플리케이션을 통합테스팅하기 위해 선호되는 방법입니다.
Cucumber는 플레인 텍스트로 씌여진 "feature documentation"을 실행할 수 있는 툴입니다.
여기에 일반적인 Cucumber의 feature 예가 있습니다:

    Feature: Login
      To ensure the safety of the application
      A regular user of the system
      Must authenticate before using the app

      Scenario: Failed Login
        Given I am not authenticated
        When I go to /login
        And I fill in "login" with "i_dont_exist"
        And I fill in "password" with "and_i_dont_have_a_password"
        And I press "Log In"
        Then the login request should fail
        Then I should see an error message

## Merb와 Cucumber{: #merb_and_cucumber}
Merb와 함께 Cucumber를 사용하기 위해서는, [merb\_cucumber][] 플러그인을 설치하셔야 합니다.
플러그인을 설치하기 위해서 다음의 명령을 실행하시기 바랍니다.

    $ sudo gem install merb_cucumber

혹은, 로컬 젬 디렉토리를 사용하고 있다면 다음 명령을 실행하십시오.

    $ thor merb:gem:install merb_cucumber

그 다음, 여러분의 merb 프로젝트 루트 디렉토리에서 다음을 실행하십시오.

    $ merb-gen cucumber

혹은, [Webrat][] 서포트를 설치하기 위해 다음을 실행하시기 바랍니다.

    $ merb-gen cucumber --session-type webrat

이렇게 함으로써 위에서 보여드린 로그인 feature를 설치할 수 있습니다.
merb-auth를 사용하고 계시다면 이 테스트는 통과될 것입니다.

여러분의 feature들을 실행하기 위해서는 간단하게 다음을 실행하시면 됩니다.

    $ rake features

## 새로운 feature 만들기{: #creating_new_features}

여러분의 Merb어플리케이션에 새로운 feature를 더하시고 싶으시다면 다음을 실행하시면 됩니다.

    $ merb-gen feature FEATURE_NAME

이 명령은  다음에서 보는 것과 같이 생긴 FEATURE\_NAME.feature 라고 명명된 feature를 feature디렉토리에 만들어줄 것입니다:

    Feature: add comment
      To [accomplish some goal]
      A [role]
      Does [something]

      Scenario: [first scenario]
        Given [precondition]
            And [another precondition]
        When [event happens]
        And [another event happens]
        Then [outcome]
        And [another outcome]

        Scenario: [other scenario]
          Given [precondition]
            And [another precondition]
          When [event happens]
          And [another event happens]
          Then [outcome]
          And [another outcome]

만약 여러분이 커맨드라인에서 feature를 실행시키시면, Cucumber가 각 스텝에서 어떻게 구현해야 하는지 힌트를 줄 것입니다.
Cucumber feature를 구현하는 보다 상세한 정보를 원하시면 [Cucumber wiki]를 방문하시기 바랍니다.

<!-- Links -->
[Cucumber]:         http://github.com/aslakhellesoy/cucumber/wikis/home
[Cucumber wiki]:    http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]:   http://github.com/david/merb_cucumber/tree/master
[Webrat]:           http://github.com/brynary/webrat/wikis
