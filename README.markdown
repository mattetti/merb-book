# The Merb Open Source Book

This book is an open source book written for and by the Merb community.

To run the book locally, just clone this repo and start bundled Merb:

		$ ./bin/merb
		
And open http://localhost:4000/ in your browser

Note that you might have to "redeploy" the native gems if the merb app server doesn't start:

		$ thor merb:gem:redeploy

A static HTML and a PDF version will soon be available online.

## How to contribute

 * Fork this project
 * Modify, fix, add content
 * send me a pull request

For the moment, the content of the book is located inside ./book-content/ and is organized by languages, chapters and pages.

Chapters and pages must be lowercase and start by a digit followed by a dash and the chapter/page title without spaces or any non ascii characters.

All content files are markdown files and the merb app uses [maruku](http://maruku.rubyforge.org) to render the markdown files. Check the [supported syntax](http://maruku.rubyforge.org/markdown_syntax.html) or check ./book-content/en/1-introduction/1-ruby.markdown for a good example of how to use images, quotes and css selectors.

The book supports multiple languages, each language needs to replicate the English folder structure with the same file names.

If you are copying a page or chapter to your language folder and want to mark a section of your text as requiring translation, just add the to-translate class to the css selector of your content as shown below:

		{: .to-translate}


## Legal

The content of this book is licensed under the [Creative Commons Attribution-Noncommercial-Share Alike 3.0 license](http://creativecommons.org/licenses/by-nc-sa/3.0/us/)

The source code of the application is dual licensed under the MIT and GPL licenses:

* [MIT](http://www.opensource.org/licenses/mit-license.php)
* [GPL](http://www.gnu.org/licenses/gpl.html)
