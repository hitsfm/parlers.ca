# parlers.ca
It's the whole dang site! HTML only, CGI Perl, Databaseless,  unrestricted (simple) social media post engine. That runs on windows. And spits out member generated static html posts "sites" url. On the index (wall) page in real-time..

Some of these project files are based on some mid 90s incomplete perl snips, and code. And heavy modified by me to create a unique system of my own for the modern web.

What you get is a static html homepage with an updated list of registered member generated posts "site" urls with a portal for members to:  register,login,upload a photo,recover lost password,modify a Post,delete a post.

Only CSS and HTML. This makes it easy to work with and design.I needed something in the inspiration of http://neocities.org But not as complicated with the same idea of a portal page, member sites get listed in realtime when they are created and updated. However. My target local community of perhaps 1k folks are not all web masters. They just want to have the freedom to post and speak without content restrictions. But the flexability is there to take advantage of for those who want to go full out on their post. Bringing back freedom and creative nice looking online posts at the local level anyways. 

So this brings me to answer why I did this. We are a local community in the far north. Even with just a little over 1k in population we still have our fair share of local drama. Mostly politics hehe. But it is always some topics the locals want to talk about and with platforms today like Twitter and Facebook AI bots blocking and filtering us at random. Moslty because what others are doing to insite an angry mob at the US Capitol. And we pay for this and are not even USA. It was becoming a problem for us. As we were using what ever platform we could take advantage of for free. But this for "free" is no longer working when you have a "fact" checker disabling one of or many of our local posts regarding a very local issue that only a local would understand to not be flagged as bad. But these folks are out working 8000 miles away from us in LA in some glass cube telling us folks what we should talk and not talk about in our small town in a country far north not even their own! Is not right and not fair so this is why I built this. It is obviously a very simple engine and if your wanting to emulate the next twitter and have millions of users, This is not the script for you!

Why this is better?

User posts are generated as real html web pages with a real http://yourdomain/yourmemberpost url. This makes your content web crawler search engine friendly. The goal here is to escape the social media and random web service "Amazon Cloud Hosting etc" restrictions of freedom of speech by running our own simple server setup and giving our users a chance to have a online voice again. Of course URL links can be shared on any platform as well! So if let's say something might be considered a little iffy for twitter. Simply post all about it on "Parlers.ca" Engine as a post page. You can have your comment, Include all supporting info, links to content, youtube videos or photos etc as you wish and generate a URL via the simple create post form. And simply share that URL instead! This has a built in search engine not depending on Google or any PHP or MySQL database or any external service. 

*There is always a risk on a URL getting flagged on social media and other platforms. But it is very very much less likely! Esp... if the post appears as a simple static html page!

This system has been tested and expected to run on a Windows XP 32 bit VM.

4GB Ram
550Gb HD image.

-Depends on default ActivePerl APi522e.exe Setup.
-Depends on default Apache apache_1.3.28-win32-x86 Setup.

-Linux folks are smart enough to modify this to work on your build.

First you will have to look at all the .pl files and modify them to suit your server settings. Such as removing all refs to "parlers.ca" with your own domain name.

*If your going to use this on linux make sure to update your path to proper perl installation, in the beggining line of every .pl file. As the files here, are all modified to work by finding the default paths on windows XP with a default install of the both mentioned files above for ActivePerl and Apache web server.

Make sure that ActivePerl and Apache are installed before proceeding with this install. I have provided these files as well for your ease as they are considered old and rare today in 2021.

WHAT DOES NOT WORK:

I have included a pl web counter module. I tried to play with it. I tried to get it to work. I got Perl to work and it is keeping track in a text file on the drive. But for some reason.... I have not been able to parse that info back into the html template. I get a broken image when I call the pl script as an image html tag. I have disabled this feature for now. But I have still included the files in case anyone wants to try and take a shot at it. If you do enable the web counter module. Expect errors!













