# 설치 방법

* This will become a table of contents (this text will be scraped).
{:toc}

프레임웍을 사용하기 위해서는 Merb를 설치해야 합니다. 그러나, Merb를 설치하기 전에 먼저 C컴파일러, 루비, [루비젬](http://www.rubygems.org/), 그리고 (모델들을 원한다면) 데이터베이스가 설치되어 있어야 합니다.

## OS X{: #os_x}

### 필요 조건{: #osx_prerequisites}
XCode(흔히 디벨로퍼 툴 이라고 부름)을 OS X CD나 [Apple 개발자 사이트](http://developer.apple.com/technology/xcode.html)에서 다운받아서  설치해야 합니다.

### Ruby & RubyGems{: #osx_rubygems}
만약 OS X 10.5 (Leopard)라면, 대부분 루비가 설치되어 있을 것입니다.

### Merb{: #osx_merb}
    $ sudo gem install merb


## Linux{: #linux}

다음은 apt-get 패키지 관리자를 사용하는 데비안 기반 리눅스 배포본(예, [우분투](http://www.ubuntu.com/))를 위한 설치방법입니다. 만약 다른 배포본을 사용하고 있으면 해당 배포본의 패키지 관리자([레드햇](http://www.redhat.com/) 시스템의 경우 yum)을 사용하기 바랍니다.

### 필요 조건{: #linux_prerequisites}

    $ sudo apt-get install build-essential libxslt-dev libsqlite3-0 libsqlite3-dev

### Ruby & RubyGems{: #linux_rubygems}

    $ sudo apt-get ruby ruby1.8-dev rdoc irb libyaml-ruby libzlib-ruby ri libopenssl-ruby \
      libxml-ruby

    $ wget "http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz"
    $ tar -xvzf rubygems-1.3.1.tgz
    $ rm rubygems-1.3.1.tgz
    $ cd rubygems-1.3.1
    $ sudo ruby setup.rb
    $ cd ..
    $ rm -r rubygems-1.3.1
    $ sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
    $ sudo gem update --system


### Merb{: #linux_merb}

    $ sudo gem install merb


## Windows{: #windows}

윈도우즈 사용자는 루비와 루비젬을 설치하기 위한 옵션이 몇가지 있습니다. 
첫번째 방법은 루비 바이너리를 다운로드하고 설치한 후 루비젬을 설치하는 것입니다.

다른 방법으로는 루비젬과 다른 것들이 같이 들어있는 [원클릭 루비 인스톨러](http://rubyinstaller.rubyforge.org/wiki/wiki.pl)를 설치하는 것입니다. 
만약 원클릭 인스톨러를 사용한다면, 설치 마법사 진행 도중에 “Enable RubyGems”를 잊지말고 체크하시기 바랍니다.

기본적으로  C:\Ruby 디렉토리에 설치가 될 것입니다. 
설치 후 다음을 실행해주시기 바랍니다.

시작  --&gt; 프로그램들 --&gt; Ruby-&lt;version&gt;
--&gt; RubyGems --&gt; RubyGems Package Manager

이것을 실행하면 C:\Ruby 디렉토리안에 있는 명령프롬프트를 열게 될 것입니다. 
그리고 사용방법들을 보여주게 될 것입니다. 이제 간단히 Merb만 설치하면 됩니다:

    C:\Ruby> gem install merb

이 명령은 젬 캐시를 업데이트하고 모든 Merb관련 젬들을 가져온 후 설치를 해야하므로 실행하는데 시간이 좀 걸릴 것입니다.

_Note_: 만약 기본으로 되어있는 SQLite 데이터베이스를 사용하기 원한다면, 별도로 다운로드하고 설치해야 합니다. 더 정보를 원하시면 [SQLite](http://www.sqlite.org/) 사이트를 방문하시기 바랍니다.
