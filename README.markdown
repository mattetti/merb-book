# The Merb Open Source Book

This book is an open source book written for and by the Merb community.

Preview: <http://book.merbist.com>

To run the book locally,
just clone this repo and start the bundled copy of Merb:

		$ ./bin/merb
		
And open http://localhost:4000/ in your browser

Note that you might have to "redeploy" the native gems
if the <tt>merb</tt> app server doesn't start:

		$ ./bin/thor merb:gem:redeploy

A static HTML and a PDF version will soon be available online.

## How to contribute

 * Install the github gem
   from <http://github.com/defunkt/github-gem/tree/master>.

		$ gem install defunkt-github -s http://gems.github.com

 * Fork the mattetti/merb-book project by clicking the fork button
   at <http://github.com/mattetti/merb-book/tree/master>.

 * Clone a copy of the repository to the local machine.

		$ git clone git@github.com:YOUR_GITHUB_USERNAME/merb-book.git

 * Choosing from the branches in Mattetti’s repo (i.e., ‘english’),
   select the LANGUAGE you're going to contribute to.

 * Enter the `merb-book` directory.

		$ cd merb-book

 * Checkout the remote branch for the LANGUAGE that you're working on.

		$ gh pull mattetti LANGUAGE

 * Checkout a local copy of your language branch.

		$ gh checkout -b LANGUAGE

 * Do a sanity check.

		$ git branch
		* LANGUAGE
		master
		mattetti/LANGUAGE

 * Set up a remote branch on github for your language.

		$ git push origin LANGUAGE

 * Modify, fix, and add content in your local LANGUAGE branch.

 * Commit your changes into your local Git repository.

		$ git commit -a

 * Merge in the upstream changes.

		$ gh pull --merge mattetti LANGUAGE

 * Push your changes back to github.

		$ git push

 * Send Mattetti a pull request.

For the moment, the content of the book
is located inside <tt>./book-content/</tt>
and is organized by languages, chapters, and pages.

Chapters and pages must be lowercase and start by a digit
followed by a dash and the chapter/page title
without spaces or any non ascii characters.

All content files are Markdown files;
the <tt>merb</tt> app uses [maruku][] to render these files.
Check the [supported syntax][]
or check ./book-content/en/1-introduction/1-ruby.markdown
for a good example of how to use images, quotes, and CSS selectors.

The book supports multiple languages.
Each language needs to replicate the English folder structure,
using the *same* file names.

If you are copying a page or chapter to your language folder
and want to mark a section of your text as requiring translation,
just add the <tt>to-translate</tt> class
to the CSS selector of your content, as shown below:

    {: .to-translate}

Please follow our editor guidelines, especially:

* use a language branch (so you can see what changed in the English content)
* one sentence per line (so merging is easier)

<http://groups.google.com/group/merb-book/web/guidelines>

## Translation leaders

* Bosnian:     http://github.com/sidonath (Damir Zekić)
* Chinese:     http://github.com/zhhz (Zhonghai Zuo)
* French:      http://github.com/pointcom  (Mathieu Fosse)
* German:      http://github.com/cypher (Markus Prinz)
* Italian:     http://github.com/carlopecchia (Carlo Pecchia)
* Japanese:    http://github.com/kwatch (Makoto Kuwata)
* Portuguese:  http://github.com/akitaonrails (Fabio Akita)
* Russian:     http://github.com/cheba (Alex Mankuta)
* Spanish:     http://github.com/joahking (Joaquin Rivera Padron)
* Dutch:       http://github.com/pvelder (Peter De Velder)
* Arabic       http://github.com/khelll (Khaled AlHabache)
* Indonesian   (pending)

## Legal

The content of this book is licensed under the [Creative Commons Attribution-Noncommercial-Share Alike 3.0 license][]

The source code of the application is dual licensed
under the MIT and GPL licenses:

* [MIT](http://www.opensource.org/licenses/mit-license.php)
* [GPL](http://www.gnu.org/licenses/gpl.html)


[Creative Commons Attribution-Noncommercial-Share Alike 3.0 license]: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
[maruku]:             http://maruku.rubyforge.org
[supported syntax]:   http://maruku.rubyforge.org/markdown_syntax.html
