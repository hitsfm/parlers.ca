#!C:\perl\bin\perl.exe
# 
#  
#####################################################################################



# A COUPLE OF THINGS TO SET!

# Path to homepage.cfg file
# Set this to the full path if you are having problems
# require "/home/usr13/html/tryhp/ezhp2000.cfg";
require "C:/Program Files/Apache Group/Apache/ezhp2000.cfg";
# Path to HTML code file (contains headers, footers, etc).
# Set this to the full path if you are having problems
# require "/home/usr13/html/tryhp/html2000.pl";
require "C:/Program Files/Apache Group/Apache/cgi-bin/html2000.pl";

# YOU DO NOT NEED TO CHANGE ANYTHING BELOW THIS LINE!
######################################################################################
use CGI; 
$SIG{__DIE__} = \&Error_Msg;

sub Error_Msg {
    $msg = "@_";
    print "\nContent-type: text/html\n\n";
    print "The following error occurred : $msg\n";
    exit;
}

# Get the input
read(STDIN, $input, $ENV{'CONTENT_LENGTH'});

    # split the input
    @pairs = split(/&/, $input);

    # split the name/value pairs
    foreach $pair (@pairs) {

    ($name, $value) = split(/=/, $pair);

    $name =~ tr/+/ /;
    $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
    $value =~ s/<([^>]|\n)*>//g;

  $FORM{$name} = $value;
    }

# Lets do some translating first
$usrname = $FORM{'usrname'};
$email = $FORM{'email'};
$background = $FORM{'background'};
$emailgif = $FORM{'emailgif'};
$linkc = $FORM{'linkc'};
$vlinkc = $FORM{'vlinkc'};
$textc = $FORM{'textc'};
$headline = $FORM{'headline'};
$subhead = $FORM{'subhead'};
$headpos = $FORM{'headpos'};
$topimage = $FORM{'topimage'};
$usecounter = $FORM{'usecounter'};
$totalReads = $FORM{'totalReads'};
$extpic = $FORM{'extpic'};
$thmimage = $FORM{'thmimage'};
$extthumb = $FORM{'extthumb'};
$line2 = $FORM{'line'};
$imageyn = "yes";
$imagepos = $FORM{'imagepos'};
$imdesc = $FORM{'imdesc'};
$contactactive = $FORM{'contactactive'};
$sxfi1 =   $FORM{'fimage1'};
$sxfi2 =   $FORM{'fimage2'};
$sxfi3 =   $FORM{'fimage3'};
$sxfi4 =   $FORM{'fimage4'};
$sxti1 =   $FORM{'timage1'};
$sxti2 =   $FORM{'timage2'};
$sxti3 =   $FORM{'timage3'};
$sxti4 =   $FORM{'timage4'};

$usrlink1 = $FORM{'usrlink1'};
$usrlink2 = $FORM{'usrlink2'};
$usrlink3 = $FORM{'usrlink3'};
$linkname1 = $FORM{'linkname1'};
$linkname2 = $FORM{'linkname2'};
$linkname3 = $FORM{'linkname3'};
$FORM{'content'}=~s/\cM//g;
$FORM{'content'}=~s/\n\n/%%/g;
$FORM{'content'}=~s/\n/<br>/g;
$content = $FORM{'content'};
$images = $FORM{'images'};
$pagename = $FORM{'pagename'};
$login = $FORM{'login'};
$uploadtype = $FORM{'uploadtype'};
$bullet = $FORM{'bullet'};
$FORM{'tbltext'}=~s/\cM//g;
$FORM{'tbltext'}=~s/\n/%%/g;
$tbltext = $FORM{'tbltext'};
$updact = $FORM{'updact'};
$font = $FORM{'font'};
$anotherline = $FORM{'anotherline'};
$emailonpage = $FORM{'emailonpage'};


# Add the line breaks for paragraph spacing
$printcontent =~ s/&&/<br><br>/g;
$printcontent =~ s/&&/%%/g;

# This fixes the bug of white space and
# other wierd spacing:
$content =~ s/\cM//g;
$content =~ s/\n/  /g;
$tbltext =~ s/\cM//g;
$tbltext =~ s/\n/  /g;

# If the user tries to add more than one word in
# the page name field, this will put an underscore
# in the spaces to make it one word
$pagename =~ s/ /_/g;

# Find out what the user wants to do
if ($FORM{'action'} eq "New Page") {
    &authnew;
    }
if ($FORM{'action'} eq "Upload Images") {
    &uploadimages;
    }

if ($FORM{'action'} eq "Lost Login") {
    &lostlogin;
    }
if ($FORM{'action'} eq "Search") {
    &checkpages;
    }
if ($FORM{'action'} eq "checkpages") {
    &checkpages;
    }

if ($FORM{'action'} eq "Create Page") {
    &create;
    }
if ($FORM{'action'} eq "Edit Page") {
    &confirm("edit");
    }
if ($FORM{'action'} eq "checkuser") {
    &checkuser;
    }
if ($FORM{'action'} eq "checkadmin") {
    &checkadmin;
    }
if ($FORM{'action'} eq "checkpriv") {
    &checkpriv;
    }

if ($FORM{'action'} eq "recreate") {
    &recreate;
    }
if ($FORM{'action'} eq "Delete Page") {
    &confirm("delete");
    }

$homepageaction = $ENV{'QUERY_STRING'};

if ($homepageaction eq "newpage") {
    &authnew;
    }
if ($homepageaction eq "uploadimages") {
    &uploadimages;
    }

if ($homepageaction eq "lostlogin") {
    &lostlogin;
    }

if ($homepageaction eq "editpage") {
    &confirm("edit");
    }
if ($homepageaction eq "delpage") {
    &confirm("delete");
    }
else { &confirm("edit"); }

sub beginpage() {
    local($usrname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos);

($usrname, $mail, $bgimage, $head, $sub, $body, $linkcolor, $vlinkcolor, 
    $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive, 
    $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos) = split(/&&/, "");

$ahref1="http://";    
$ahref2="http://";
$ahref3="http://";
$login = "";
$email = "";
$usrname = "";
$pagename = "";
$headline = "";
$sunhead = "";
$totalReads = "0";
$xfi1="";
$xfi2="";
$xfi3="";
$xfi4="";
$xti1="";    
$xti2="";
$xti3="";
$xti4="";
$extthumb = "";
$extpic = "";
$textcolor="#000000";
$linkcolor="#0000ff";
$vlinkcolor="#800000";
$bullet="0";
# To avoid any security risks. Take out the HTML tags added when HPM translated
# the && to: <br><br>. They will be re-translated to: && Once the user updates
# the page, the: && will be put back to: <br><br>
$body =~ s/<br><br>/&&/g;

# print the create-page form

print "Content-type: text/html\n\n";
print "<html><head><title>Create Your Post</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print qq~
<DIV align="center">
  <CENTER>
  <TABLE border="0" width="90%" cellspacing="0" cellpadding="0">
    <TR>
      <TD width="100%"><FONT face="verdana, helvetica, arial" size="4" color="#FF0000">Create
        your unrestricted post.</FONT>
        <P><FONT face="verdana, helvetica, arial" size="2">This post
        creation tool is a quick and easy way of creating a simple Parlers.ca page.
        Fill in the form fields below to create your post. You may edit any part
        of your post later.</FONT></P>
        <HR noshade size="1">
<form action="$cgiurl" method="POST">
<input type=hidden name="action" value="Create Page">
<TABLE border="0" width="100%" cellspacing="3" cellpadding="5">
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Your
              name:<BR>
              </B>(will appear as an email link)<BR>
              </FONT><input type=text size=40 name=usrname value="$usrname"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Login
              ID:</B><BR>
              (required for editing - must not be easy to guess, and should always be kept secret)<BR>
              </FONT><input type=password size=40 name=login value=""><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Email
              address</B><B>:</B><BR>
              (required for editing and appears in post - must be valid)<BR>
              </FONT><input type=text size=40 name=email value="$mail"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>

          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>File
              name:</B><BR>
              (will become the file name of your post page - one word, letters and/or numbers only - no extension please)<BR>
              </FONT><input type=text size=40 name=pagename value="$filename"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Headline:</B><BR>
              (appears as the title and headline of your post, and entry in our
              index of posts)<BR>
              </FONT><input type=text size=40 name=headline value="$head"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Sub
              heading:<BR>
              </B>(appears beneath the headline)<BR>
              </FONT><input type=text size=40 name=subhead value="$sub"></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Do
              you want the headline and sub heading centered?<BR>
              </B></FONT><input type=radio name=headpos value=yes checked><FONT face="verdana, helvetica, arial" size="1"><b> Yes</b>&nbsp;
              </FONT><input type=radio name=headpos value=no><FONT face="verdana, helvetica, arial" size="1"><b> No</b></FONT></TD>
          </TR>
          <TR>
                      <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Text
                        font face:</B><BR>
                        (select a font face and alternatives - eg. 'verdana, helvetica,
                        arial')<BR>
                        </FONT><input type=text size=40 name=font value='verdana, helvetica, arial'></TD>
                    </TR>

~;

&build_form_body($usrname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos);
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><P><input type=submit value=\"Create Page\"><br><FONT face=\"verdana, helvetica, arial\" size=\"1\">By hitting 'Create Page' your page will be generated. If you don't like the look of your page you can edit it at any time by visiting the user pages listing and selecting 'Edit Page'\n";
print "</font></TD></TR></TABLE></form>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></center></DIV></body></html>\n";
exit;
    }

sub create {

# Now, lets do some error checking. Making sure they filled out each field
# This is pretty low tech now. I'll improve it later
&missing(name) unless $usrname;
&missing(email) unless $email;
&missing(pagename) unless $pagename;




&missing(missing_name) unless $usrname;
&missing(missing_email) unless $email;
&missing(missing_pagename) unless $pagename;

# if they try to name their page "index" This will stop them
if ($pagename eq "index") {
    print "Content-type: text/html\n\n";
    print "<html><head><title>Error</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Error</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The file name 'index' can't be used. Please go back and rename your page!</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
    exit;
        }
# if they Don't give their page a heading This will stop them
if ($headline eq "") {
    print "Content-type: text/html\n\n";
    print "<html><head><title>Error</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Error</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">You must enter a headline for your post. Please go back and enter a headline!</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
    exit;
        }

# if the user tries to name their page 
# something that is already taken
# this will HOPEFULLY stop them :)
# This block was written by Norm
if (-e "$page_dir$pagename\.$fileext") {
    print "Content-type: text/html\n\n";
    print "<html><head><title>Error</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Error</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The file name you selected is already taken. Please go back and rename your post!</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
    exit;
        }

#now, lets create our new html page
  &buildpage;

# Write the login name and email address to a separate file for confirmation
# when they want to edit their page
open (FILE, ">>$data") || die "I can't open $data\n";
if ($useflock) {
flock (FILE, 2) or die "can't lock data file\n";
}
print FILE "$login&&$email&&$pagename\n";
close(FILE);
$indeximage = $thmimage;
    if (($thmimage eq "0") or ($thmimage eq "")) {
    if($extthumb ne ""){
    $indeximage = $extthumb;
        }
        }
# Suck the index page, and write the new entry to it
open(FILE, "$indexpage") || die "I can't open that file\n";
if ($useflock) {
flock (FILE, 1) or die "can't lock index file\n";
}
    @lines = <FILE>;
    close(FILE);
    $sizelines = @lines;

# Now, re-open the links file, and add the new link
open(FILE, ">$indexpage") || die "I can't open that file\n";
if ($useflock) {
flock (FILE, 2) or die "can't lock index file\n";
}
    
        for ($a = 0; $a <= $sizelines; $a++) {
    
        $_ = $lines[$a];

    if (/<!--begin-->/) {
    print FILE "<!--begin-->\n";
    if (($indeximage eq "0") or ($indeximage eq "")) {
    print FILE "<p><center><font face=\"$myfontface\" size=2><a href=\"$baseurl/$pagename.$fileext\"><b>$headline</b></a></font></center></p>\n";
   }else{
    print FILE "<p><center><font face=\"$myfontface\" size=2><a href=\"$baseurl/$pagename.$fileext\"><IMG SRC=\"$indeximage\"></a><br><b>$headline</b></center></p>\n";
    }

        } else {
            print FILE $_;
        }
    }
close(FILE);


# Give the user a response

print "Content-type: text/html\n\n";
print "<html><head><title>Your Parlers.ca post has been created</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Your page has been created</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Your page has been created, and you should receive a confirmation email.</p>\n";
print "<p>Your post URL is: <a href=\"$baseurl/$pagename\.$fileext\">\n";
print "$baseurl/$pagename\.$fileext</a> - you may need to press reload / refresh in your browser to view the changes.</p>\n";
print "<p>(Return to <a href=\"$baseurl/\">User Posts</a>)</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";

    

# Send the user an e-mail confirming their page
open (MAIL, "| $sendmail -t") || die "I can't open sendmail\n";
  print MAIL "To: $usrname <$email>\n";
  print MAIL "From: $myemail\n";
  print MAIL "Subject: Your URL on $title\n";
  print MAIL "Your post can be viewed at the URL below:\n\n";
  print MAIL "$baseurl/$pagename\.$fileext\n\n";
  print MAIL "Below is the information to edit your post at any time that you choose.";
  print MAIL "\n\nYour email is $email ";
  print MAIL "\nYour Login name is $login ";
  print MAIL "\nYour page name is $pagename";
  print MAIL "\n\nThank you for using $title\n";
  print MAIL "\n\n$title - $myemail\n";
  close (MAIL);

# Notify us when someone creates a page
open (MAIL, "| $sendmail -t") || die "I can't open sendmail\n";
  print MAIL "To: $myemail\n";
  print MAIL "From: $usrname <$email>\n";
  print MAIL "Subject: New Page Report\n";
  print MAIL "$usrname created a new page:\n";
  print MAIL "$baseurl/$pagename\.$fileext\n";
  print MAIL "\nThe content is :\n$content\n";
close(MAIL);
exit;
        }

sub recreate {
#now, lets create our new html page
  &buildpage;
  

# Send the user a notice that their page has been re-done
  open (MAIL, "| $sendmail -t") || die "I can't open sendmail\n";
  print MAIL "To: $usrname <$email>\n";
  print MAIL "From: $myemail\n";
  print MAIL "Subject: Your Changes on $title\n";
  print MAIL "Your revised page can be viewed at the URL below:\n";
  print MAIL "\n";
  print MAIL "$baseurl/$pagename\.$fileext\n";
  print MAIL "\nOnce again thank you for using $title\n";
  print MAIL "\n\n$title - $myemail\n";
  close (MAIL);

# Give the user a response
print "Content-type: text/html\n\n";
print "<html><head><title>Your post has been updated</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Your post has been updated</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Your post has been updated, and you should receive a confirmation email.</p>\n";
print "<p>Your post URL is: <a href=\"$baseurl/$pagename\.$fileext\">\n";
print "$baseurl/$pagename\.$fileext</a> - you may need to press reload / refresh in your browser to view the changes.</p>\n";
print "<p>(Return to <a href=\"$baseurl/\">User Posts</a>)</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";

##########################################
#BILL HALL MOD
#check to see if csreeditindex is on
  if($csreeditindex){
  &csreeditentry;
  }
##########################################

exit;
        }

sub buildpage {
open(HTML, ">$page_dir$pagename\.$fileext") || die "I can't create $pagename\.$fileext\n";
if ($useflock) {
flock (HTML, 2) or die "can't lock html file\n";
}
print HTML "<html><head><title>$headline</title>\n";
 if($usebanner eq "Y"){
# the next few lines are banner printing code
 print HTML ("<SCRIPT LANGUAGE=JavaScript>\n");
 print HTML ("<!--\n");
 print HTML ("window.open(\"$banner\", \"w3adIAYJAAII\",\n");
 print HTML ("\"width=515,height=125\")\;\n");
 print HTML ("//-->\n");
 print HTML ("</SCRIPT>\n");
 }
print HTML "</head>";
print HTML $hp_css;
print HTML "<body ";

if ($background eq "0") {
print ""; }
else {
print HTML "background=\"$background\" ";
}

print HTML "text=$textc link=$linkc vlink=$vlinkc><font face=\"$font\">\n";
print HTML "$userpage_header\n";
print HTML "<blockquote><blockquote><blockquote>\n";
    if ($headpos eq "yes") {
    print HTML "<center>\n";
        }
print HTML "<p><font face=\"$font\" size=+7><b>$headline</b></font></br>\n";
print HTML "<font face=\"$font\" size=+2><b>$subhead</b></font></p>\n";
    if ($headpos eq "yes") {
    print HTML "</center>\n";
        }
    if ($imageyn eq "yes") {
    if ($imagepos eq "yes") {
    print HTML "<center>\n";
        }
    $pageimage = $topimage;
    if (($topimage eq "0") or ($topimage eq "")) {
    if($extpic ne ""){
    $pageimage = $extpic;
        }
      }

    if (($pageimage eq "0") or ($pageimage eq "")) {
        print HTML "";
        }
    else  {
        print HTML "<img src=\"$pageimage\">\n";
        }
    if($usecounter ne "N")
    {
    if($usecounter eq "WOB"){
    print HTML "<br><i><font face=\"$font\" size=3><b>$counterstring</i></b></font>\n";
    print HTML "<img src=\"$wobcounterurl?$page_dir$pagename\.cnt\">\n";
    }
    else
    {
    print HTML "<br><i><font face=\"$font\" size=3><b>$counterstring</i></b></font>\n";
    print HTML "<img src=\"$bowcounterurl?$page_dir$pagename\.cnt\">\n";
   
    }
     }

    if ($imagepos eq "yes") {
    print HTML "</center>\n";
        }
  $grx = $sxti1.$sxti2.$sxti3.$sxti4;
  if ($grx ne "")
  {
    print HTML "<center><TABLE>";
    print HTML  "<TR>";
   
  if($useexternalextragraphics eq "Y"){
   $dxti1 =  $sxti1;
   $dxti2 =  $sxti2;
   $dxti3 =  $sxti3;
   $dxti4 =  $sxti4;
   $dxfi1 =  $sxfi1;
   $dxfi2 =  $sxfi2;
   $dxfi3 =  $sxfi3;
   $dxfi4 =  $sxfi4;
   }
   else
   {
   $dxti1 =  $tnxt_dir_url/$sxti1;
   $dxti2 =  $tnxt_dir_url/$sxti2;
   $dxti3 =  $tnxt_dir_url/$sxti3;
   $dxti4 =  $tnxt_dir_url/$sxti4;
   $dxfi1 =  $tnxp_dir_url/$sxfi1;
   $dxfi2 =  $tnxp_dir_url/$sxfi2;
   $dxfi3 =  $tnxp_dir_url/$sxfi3;
   $dxfi4 =  $tnxp_dir_url/$sxfi4;
   }
  if ($sxti1 ne "")
  {
  print HTML   "<TD><P ALIGN=Center>\n";
  if ($sxfi1 ne "")
  {
  print HTML "<A HREF=\"$dxfi1\"><IMG SRC=\"$dxti1\"></A>";
  }
  else
  {
  print HTML "<IMG SRC=\"$dxti1\">";
  }
      print HTML "<P ALIGN=Center>";
      print HTML "</TD>\n";
  }
  if ($sxti2 ne "")
  {
  print HTML   "<TD><P ALIGN=Center>\n";
  if ($sxfi2 ne "")
  {
  print HTML "<A HREF=\"$dxfi2\"><IMG SRC=\"$dxti2\"></A>";
  }
  else
  {
    print HTML "<IMG SRC=\"$dxti2\">";
  }
      print HTML "<P ALIGN=Center>";
      print HTML "</TD>\n";
 }
  if ($sxti3 ne "")
  {
  print HTML   "<TD><P ALIGN=Center>\n";
  if ($sxfi3 ne "")
  {
  print HTML "<A HREF=\"$dxfi3\"><IMG SRC=\"$dxti3\"></A>";
  }
  else
  {
   print HTML "<IMG SRC=\"$dxti3\">";
  }
      print HTML "<P ALIGN=Center>";
      print HTML "</TD>\n";
 }
  if ($sxti4 ne "")
  {
  print HTML   "<TD><P ALIGN=Center>\n";
  if ($sxfi4 ne "")
  {
  print HTML "<A HREF=\"$dxfi4\"><IMG SRC=\"$dxti4\"></A>";
  }
  else
  {
   print HTML "<IMG SRC=\"$dxti4\">";
   }
      print HTML "<P ALIGN=Center>";
      print HTML "</TD>\n";
 }
     print HTML  "</TR>";
     print HTML "</TABLE></center>\n";
     }

    print HTML "<center>";
    if (($line2 eq "0") or ($line2 eq "")) {
        print HTML "</center>";
        } 
    else {
       print HTML "</blockquote></blockquote></blockquote><img src=\"$line2\"></center><blockquote><blockquote><blockquote>\n";
        }
    }


@atxt = split(/%%/, $content);

if ($bullet eq "0") {
  print HTML "<center>\n";
  foreach $txtline(@atxt) {
      print HTML "<p><font face=\"$font\" size=3>$txtline</font>\n";
    }
  print HTML "</center>";
  }
else {
print HTML "<table border=0 cellpadding=5>\n";
foreach $txtline (@atxt) {
  print HTML "<tr><td valign=top><img src=\"$bullet\"></td>\n";
  print HTML "<td><font face=\"$font\" size=3>$txtline</font></td></tr>\n";
  }
print HTML "</table>\n";
}

print HTML "<center>\n";
print HTML "<p><table border=1 cellspacing=3 cellpadding=3>";
@all = split(/%%/,$tbltext);
foreach $tbline (@all) {
    print HTML "<tr>";
    @flds = split(/\:\:/, $tbline);
    foreach $fld (@flds) {
        print HTML "<td>$fld</td>";
        }
    print HTML "</tr>";
    }
print HTML "</table>";
print HTML "</center>";

if ($bullet eq "0") {
  print HTML "<center>\n";
  }
  
  $togo = $linkname1.$linkname2.$linkname3;
  $tourl = $usrlink1.$usrlink2.$usrlink3;
  if (($togo eq "") or $tourl eq "http://http://http://") {
          print HTML "";
          } 
      else {
     print HTML "<p><i><font face=\"$font\" size=4><b>$rellinks</i></b></font></p>\n";
   print HTML "<p><font face=\"$font\" size=3><a href=\"$usrlink1\">$linkname1</a><br>\n";
print HTML "<a href=\"$usrlink2\">$linkname2</a><br>\n";
print HTML "<a href=\"$usrlink3\">$linkname3</a></font></p>\n";
      }
if ($bullet eq "0") {
  print HTML "</center>\n";
  }

print HTML "<center>";
if (($anotherline eq "0") or ($anotherline eq "")) {
print HTML "";
    } else {
print HTML "</blockquote></blockquote></blockquote><img src=\"$anotherline\"></center><blockquote><blockquote><blockquote>\n";
    }
print HTML "<p><center>";

# Contact Form Here
 if($contactactive eq "Yes")
 {
  print HTML "<center><form method=\"POST\" action=\"$contacturl?to=$email\">";
 print HTML "<br>Use The Button Below To Contact Me!";
 if($emailonpage ne "No"){
  print HTML "<br>If Your Browser Does Not Support forms";
  print HTML "<br>Use The Email Link Below";
 }
 print HTML "<input type=hidden name=\"to\" value=\"$email\">";
 
 print HTML "<p><input type=\"submit\" value= \"Contact Me\">\n";

 print HTML "</form></center>";

}
 if ($emailonpage ne "No") {
     if ($emailgif eq "0") {
print HTML "<font face=\"$font\" size=3>Email: <a href=\"mailto:$email\">$usrname</a></font></center></p>\n";
}
     else {
print HTML "<a href=\"mailto:$email\"><img src=\"$emailgif\" ALT = \"$usrname\"><br>\n";
    }
}

print HTML "<p><center><font face=\"$font\" size=2>";
print HTML "$copyright_notice</b></a></font>";
print HTML "</blockquote></blockquote></blockquote>\n";
print HTML "</center></body></html>";

close(HTML);


# Write all of the input into a flat file.
open(FILE, ">$page_dir$pagename\.dat") || die "I can't create $pagename\.dat\n";
if ($useflock) {
flock (FILE, 2) or die "can't lock user data file\n";
}
$tbltext =~ s/\n/%%/g;
print FILE "$usrname&&$email&&$background&&$headline&&$subhead&&$content&&$linkc&&$vlinkc&&$usrlink1&&$usrlink2&&$usrlink3&&$linkname1&&$linkname2&&$linkname3&&$sxfi1&&$sxfi2&&$sxfi3&&$sxfi4&&$sxti1&&$sxti2&&$sxti3&&$sxti4&&$contactactive&&$pagename&&$topimage&&$usecounter&&$extpic&&$thmimage&&$extthumb&&$line2&&$emailgif&&$textc&&$bullet&&$tbltext&&$font&&$anotherline&&$emailonpage&&$headpos&&$imagepos\n";
close(FILE);
chmod 0777, '$page_dir$pagename.dat';
if($allowcounter eq "Y")
{
if($totalReads <= 0){
$totalReads eq "0";
}
open(COUNT,">$page_dir$pagename\.cnt");
print (COUNT "$totalReads\n");
close(COUNT);
chmod 0777, '$page_dir$pagename.cnt';

}
 }

# Standard error message for any missing required fields
sub missing {
local ($missing) = @_;

    print "Content-type: text/html\n\n";
    print "<html><head><title>Error</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Error</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">You forgot to fill in one or more required fields. Please go back and fill them in!</p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Missing field: $missing</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
    exit;
        
}
sub authnew{
if($turnkey eq "Y"){
print "Content-type: text/html\n\n";
print "<html><head><title>Login</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Login</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Enter your admin login</font></b></p>\n";
print "<form action=\"$cgiurl\" method=POST>\n";
print "<TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"5\"><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\">\n";
print "<b>Login name:</b><br></font>\n";
print "<input size=40 type=password name=\"login\" value= \"\">\n";
# print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>e-mail:</b><br></font>\n";
# print "<input size=40 type=text name=\"email\" value= \"\"></td></tr>\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><input type=\"submit\" value=\"Login\">\n";
print "<input type=hidden name=\"action\" value=\"checkadmin\">\n";
print "</td></form></tr></table></table>\n";
print $badj_seperator;
print $badj_footer;
print $badj_seperator;
require "ezskipme.pl";
print "</td></tr>";
print "</body></html>\n";
exit;
    }
else
{
&beginpage;
}
}

sub checkadmin{
    if("$login" eq $adminbd) {
        $match = 1;
          &beginpage;
          }
    else
 {
    $match = 0;
    &error;
    }
}



sub confirm {
    local ($updact) = @_;

print "Content-type: text/html\n\n";
print "<html><head><title>$updact Login</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Login</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Enter your login name, original e-mail address and name of your file to <b>$updact</b></p>\n";
print "<form action=\"$cgiurl\" method=POST>\n";
print "<TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"5\"><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\">\n";
print "<b>Login name:</b><br></font>\n";
print "<input size=40 type=password name=\"login\" value = \"\">\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>E-mail (original):</b><br></font>\n";
print "<input size=40 type=text name=\"email\" value = \"\">\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Name of your file (no extension please):</b><br></font>\n";
print "<input type=text size=40 name=\"pagename\" value = \"\">\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><input type=\"submit\" value=\"Login\">\n";
print "<input type=hidden name=\"action\" value=\"checkuser\">\n";
print "<input type=hidden name=\"updact\" value=\"$updact\">\n";
print "</FONT></td></form></tr></table>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
exit;
    }


sub checkuser {

open(FILE, "$data") || die "I can't open $data\n";  
$adminoverride = 0;
$loginmatch = 0;
if($login eq $adminbd) 
{
$adminoverride = 1;
}
if ($useflock) {
flock (FILE, 1) or die "can't lock data file\n";
}

    while(<FILE>) {
    chop;       
    @all = split(/\n/);

    foreach $line (@all) {
    ($loginname, $loginemail, $loginpagename) = split(/&&/, $line);
    if(($loginname eq "$login") && ($loginemail eq "$email"))
     {
   $loginmatch = 1;
    }
 if(($loginpagename eq "$pagename")&&(($adminoverride) || ($loginmatch)))  {
        $match = 1;
        if($updact eq "edit") {
          &edit($loginpagename);
          }
        else {
          &delpage($loginpagename);
          }
        }
      }
    }

close(FILE);

if (! $match) {
    &error;
    }

# del entry from data
if($updact eq "delete") {

    # Suck the index page, and write the new entry to it
    open(FILE, "$data") || die "I can't open that file\n";
    if ($useflock) {
    flock (FILE, 1) or die "can't lock data file\n";
    }
        @lines = <FILE>;
        close(FILE);
        $sizelines = @lines;

    # Now, re-open the links file, and comment out the page to delete
    open(FILE, ">$data") || die "I can't open that file\n";
    if ($useflock) {
    flock (FILE, 2) or die "can't lock index file for append\n";
    }
    chop;
            for ($a = 0; $a <= $sizelines; $a++) {
            $_ = $lines[$a];
            $w = $_;
            $w =~ s/\cM//g;
            $w =~ s/\n//g;
    ($loginname, $loginemail, $loginpagename) = split(/&&/, $w);
    if($loginname eq "$login" && $loginemail eq "$email" && $loginpagename eq "$pagename") {
          # do nothing  (ie. don't write)
          } 
        else {
          if($w eq "") {
            # do nothing (skip)
            }
          else {
            print FILE "$w\n";
            }
          }
        }
    close(FILE);
    print "Content-type: text/html\n\n";
    print "<html><head><title>$updact Confirmation</title>\n";
    print $badj_css;
    print "</head>";
    print $badj_body;
    print $badj_header;
    print $badj_seperator;
    print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
    print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
    print "Your post has been deleted</font></p>\n";
    print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">(Return to <a href=\"$baseurl/\">User Posts</a>)</p>\n";
    print $badj_seperator;
    print $badj_footer;
    print "</td></tr></table>\n";
    print "</form></body></html>\n";
  }
  exit;
}

sub edit {
   
    local ($editfile) = @_;
    
    open(FILE, "$page_dir$editfile\.dat") || die "I can't open $editfile\n";
    if ($useflock) {
    flock (FILE, 1) or die "can't lock data file for edit\n";
    }

    while(<FILE>) {
    chop;
    @datafile = split(/\n/);

    foreach $line (@datafile) {
        &build_edit_form($line);
            }
         }
    close(FILE);

    }



sub delpage {
    local ($editfile) = @_;
    if($allowcounter eq "Y")
    {
    $cnt=unlink "$page_dir$editfile\.dat", "$page_dir$editfile\.$fileext", "$page_dir$editfile\.cnt" ;
    }
    else
    {
        $cnt=unlink "$page_dir$editfile\.dat", "$page_dir$editfile\.$fileext" ;
    }
    # Suck the index page, and write the new entry to it
    open(FILE, "$indexpage") || die "I can't open that file\n";
    if ($useflock) {
    flock (FILE, 1) or die "can't lock index file\n";
    }
        @lines = <FILE>;
        close(FILE);
        $sizelines = @lines;

    # Now, re-open the links file, and comment out the page to delete
    open(FILE, ">$indexpage") || die "I can't open that file\n";
    if ($useflock) {
    flock (FILE, 2) or die "can't lock index file to delete entry\n";
    }

            for ($a = 0; $a <= $sizelines; $a++) {

            $_ = $lines[$a];

        if (/$pagename.$fileext/) {
          # do nothing  (ie. don't write)
          } 
        else {
          print FILE $_;
           }
        }
    close(FILE);
    
   }


##############################################################
# Bill Hall mod - this re-edits the index page when a user
# page is edited and changes the title
# Thanks Bill!

sub csreeditentry {
    local ($editfile) = @_;
    # Suck the index page, and write the new entry to it
    open(FILE, "$indexpage") || die "I can't open that file\n";

    if ($useflock) {
    flock (FILE, 1) or die "can't lock index file\n";
    }
    
        @lines = <FILE>;
        close(FILE);
        $sizelines = @lines;

    # Now, re-open the links file, and comment out the page to delete
    open(FILE, ">$indexpage") || die "I can't open that file\n";
    if ($useflock) {
    flock (FILE, 2) or die "can't lock index file to delete entry\n";
    }

            for ($a = 0; $a <= $sizelines; $a++) {

            $_ = $lines[$a];

        if (/$pagename.$fileext/) {
          # do nothing  (ie. don't write)
          } 
        else {
          print FILE $_;
           }
        }
    close(FILE);
$indeximage = $thmimage;
    if (($thmimage eq "0") or ($thmimage eq "")) {
    if($extthumb ne ""){
    $indeximage = $extthumb;
        }
     }
# Suck the index page, and write the new entry to it
 open(FILE, "$indexpage") || die "I can't open that file\n";
 if ($useflock) {
 flock (FILE, 1) or die "can't lock index file\n";
 }
    @lines = <FILE>;
    close(FILE);
    $sizelines = @lines;

# Now, re-open the links file, and add the new link
 open(FILE, ">$indexpage") || die "I can't open that file\n";
 if ($useflock) {
 flock (FILE, 2) or die "can't lock index file\n";
 }
    
        for ($a = 0; $a <= $sizelines; $a++) {
    
        $_ = $lines[$a];

    if (/<!--begin-->/) {
    
    print FILE "<!--begin-->\n";
    if (($indeximage eq "0") or ($indeximage eq "")) {
    print FILE "<p><center><font face=\"$myfontface\" size=2><a href=\"$baseurl/$pagename.$fileext\"><b>$headline</b></a></font></center></p>\n";
 

   }else{

    print FILE "<p><center><font face=\"$myfontface\" size=2><a href=\"$baseurl/$pagename.$fileext\"><IMG SRC=\"$indeximage\"></a><br><b>$headline</b></font></center></p>\n";

    }

    
        } else {
            print FILE $_;
        }
    }
 close(FILE);
     }

###############################


sub build_edit_form($line) {
    local ($line) = @_;
    local($fullname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos);

($fullname, $mail, $bgimage, $head, $sub, $body, $linkcolor, $vlinkcolor, $ahref1, $ahref2,
 $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4,  $contactactive, $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, 
 $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos) = split(/&&/, $line);
if($allowcounter eq "Y")
{
&gethits;
}
    
# To avoid any security risks. Take out the HTML tags added when HPM translated
# the && to: <br><br>. They will be re-translated to: && Once the user updates
# the page, the: && will be put back to: <br><br>
$body =~ s/<br><br>/&&/g;

# print the edit-page form


print "Content-type: text/html\n\n";
print "<html><head><title>Edit your post</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print qq~
<DIV align="center">
  <CENTER>
  <TABLE border="0" width="90%" cellspacing="0" cellpadding="0">
    <TR>
      <TD width="100%"><FONT face="verdana, helvetica, arial" size="4" color="#FF0000">Edit your home page</FONT>
        <P><FONT face="verdana, helvetica, arial" size="2">To edit your post change the necessary elements below.</FONT></P>
        <HR noshade size="1">
<form action="$cgiurl" method="POST">
<input type=hidden name="action" value="recreate">
<TABLE border="0" width="100%" cellspacing="3" cellpadding="5">
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Your
              name:<BR>
              </B>(will appear as an email link)<BR>
              </FONT><input type=text size=40 name=usrname value="$fullname"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Email
              address</B><B>:</B><BR>
              (required for editing and appears in post page - must be valid)<BR>
              </FONT><input type=text size=40 name=email value="$mail"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          
          
         
          
          <TR>
          <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Filename
          of page:</B> $filename</FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Headline:</B><BR>
              (appears as the title and headline of your post page, and entry in our
              index of user posts)<BR>
              </FONT><input type=text size=40 name=headline value="$head"><FONT face="verdana, helvetica, arial" size="1"><I>
              required</I></FONT></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Sub
              heading:<input type=hidden name="pagename" value="$filename"><BR>
              </B>(appears beneath the headline)<BR>
              </FONT><input type=text size=40 name=subhead value="$sub"></TD>
          </TR>
          <TR>
            <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Do
              you want the headline and sub heading centered?<BR>
              </B></FONT><input type="radio" name="headpos" value="yes"
~;
         
if ($headpos eq "yes") {print " checked";}
         
print qq~
><FONT face="verdana, helvetica, arial" size="1"><b> Yes</b>&nbsp;
              </FONT><input type="radio" name="headpos" value="no"
~;
         
if ($headpos eq "no") {print " checked";}
         
print qq~
><FONT face="verdana, helvetica, arial" size="1"><b> No</b></FONT></TD>
          </TR>
          <TR>
                      <TD width="100%" bgcolor="#A0BAD3"><FONT face="verdana, helvetica, arial" size="1"><B>Text
                        font face:</B><BR>
                        (select a font face and alternatives - eg. 'verdana, helvetica,
                        arial')<BR>
                        </FONT><input type=text size=40 name="font" value="$font"></TD>
                    </TR>


~;

&build_form_body($fullname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3,$ xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos);
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><P><input type=submit value=\"Update Page\"><br><FONT face=\"verdana, helvetica, arial\" size=\"1\">By hitting 'Create Page' your page will be generated. If you don't like the look of your page you can edit it at any time by visiting the user pages listing and selecting 'Edit Page'\n";
print "</font></TD></TR></TABLE></form>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></center></DIV></body></html>\n";
    
    }

sub gethits
{
   open(COUNT,"$page_dir$pagename\.cnt");
   $totalReads = <COUNT>;
   chomp $totalReads;
   close(COUNT);
}
sub build_form_body($fullname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos) {
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Index Thuumbnail:</b><br>(Displayed on Index Page)</font></p>\n";
      opendir (TN, "$tnt_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";
   if(($timurl eq "0") || ($timurl eq ""))
   {
   print "<p><input type=radio name=\"thmimage\" value=\"0\" checked><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No Graphic</b></font></p>\n";
   }
   else
   {
   print "<p><input type=radio name=\"thmimage\" value=\"0\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No Graphic</b></font></p>\n";

   }
if($allowexternalgraphics eq "Y"){
print "<br><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>If You Select No Graphic - You May Type In The URL To Your Own Below or leave it blank:<BR></B></font>\n";
print "<input type=text size=60 name=extthumb value=\"$extthumb\"><p>\n";
}
else
{
print "<input type=hidden name=extthumb value=\"\"\n";
}
   $lend = "0";
while ($tnnum > $cnum) {
   print "<input type=radio name=\"thmimage\" value=\"$tnt_dir_url/$tnlist[$cnum]\"";
   if ($timurl eq "$tnt_dir_url/$tnlist[$cnum]") {print " checked";}
   print "><img src=\"$tnt_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tnt_dir_url/$tnlist[$cnum]\">\n";
   $cnum = $cnum + 1;
   $lend = $lend + 1;
   if ($lend eq "4"){
   print "<br><br>\n";
   $lend = 0;
    }
   }
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Page Graphic:</b><br>(displayed directly below sub heading)</font></p>\n";
      opendir (TN, "$tnp_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";
   if(( $imurl eq "0")||($imurl eq ""))
   {
   print "<p><input type=radio name=\"topimage\" value=\"0\" checked><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No graphic</b></font></p>\n";
   }
   else
   {
   print "<p><input type=radio name=\"topimage\" value=\"0\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No graphic</b></font></p>\n";
   }
if($allowexternalgraphics eq "Y"){
print "<br><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>If You Select No Graphic - You May Type In The URL To Your Own Below or leave it blank:<BR></B></font>\n";
print "<input type=text size=60 name=extpic value=\"$extpic\"><p>\n";
}
else
{
print "<input type=hidden name=extpic value=\"\"\n";
}


   $lend = "0";
while ($tnnum > $cnum) {
   print "<input type=radio name=\"topimage\" value=\"$tnp_dir_url/$tnlist[$cnum]\"";
   if ($imurl eq "$tnp_dir_url/$tnlist[$cnum]") {print " checked";}
   print "><img src=\"$tnp_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tnp_dir_url/$tnlist[$cnum]\">\n";
   $cnum = $cnum + 1;
   $lend = $lend + 1;
   if ($lend eq "4"){
   print "<br><br>\n";
   $lend = 0;
    }
   }
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Do you want the image centered?</b></font><br><input type=radio name=\"imagepos\" value=\"yes\"";
if ($imagepos eq "no") {print "";} else {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\">Yes&nbsp;&nbsp;</font>\n";
print "<input type=radio name=\"imagepos\" value=\"no\"";
if ($imagepos eq "no") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\">No</font></p>\n";
print "</td></tr>\n";
if($allowcounter eq "Y")
{
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Counter Options:</b><br></font></p>\n";
print "<p><input type=radio name=\"usecounter\" value=\"N\"";
   if(($usecounter eq "N")||($usecounter eq "")) {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Do Not Use Counter</b></font></p>\n";
print "<p><input type=radio name=\"usecounter\" value=\"WOB\"";
   if($usecounter eq "WOB") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Use White Numbers On Black Counter</b></font></p>\n";
print "<p><input type=radio name=\"usecounter\" value=\"BOW\"";
   if($usecounter eq "BOW") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Use Black Numbers On White Counter</b></font></p>\n";

print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Set or Reset Hits:</b>";
print "\n<input type=text size=10 name=\"totalReads\" value=\"$totalReads\"></font></p>";
 print "</td></tr>\n";
}
else
{
print "<TR><TD>";
print "<input type=hidden name=\"usecounter\" value=\"N\">";
print "<input type=hidden name=\"totalReads\" value=\"0\">";
print "</TR></TD>";

}

if($allowextras eq "Y")
{
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\">";
 if($useexternalextragraphics eq "Y")
 {
print " <p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Optional Extra Graphics</b><br>(Enter The Full Paths (URL) Case Sensitive - full images are linked to thumnail images)</font></p>\n";
 }
 else
 {
print " <p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Optional Extra Graphics</b><br>(Enter Case Sensitive File Names Only - full images are linked to thumnail images in the prescribed directories)</font></p>\n";

 }
print "<table width=\"75%\" cellpadding=2 cellspacing=2 border=0>\n";
print "<tr><td width=\"50%\" align=left valign=top>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Full Image 1:<br></font>\n";
print "<input type=text size=40 name=\"fimage1\" value=\"$xfi1\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Full Image 2:<br></font>\n";
print "<input type=text size=40 name=\"fimage2\" value=\"$xfi2\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Full Image 3:<br></font>\n";
print "<input type=text size=40 name=\"fimage3\" value=\"$xfi3\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Full Image 4:<br></font>\n";
print "<input type=text size=40 name=\"fimage4\" value=\"$xfi4\"></p>\n";
print "</td>\n";

print "<td width=\"50%\" align=left valign=top>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Thumnail 1:<br></font>\n";
print "<input type=text size=40 name=\"timage1\" value=\"$xti1\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Thumbnail 2:<br></font>\n";
print "<input type=text size=40 name=\"timage2\" value=\"$xti2\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Thumbnail 3:<br></font>\n";
print "<input type=text size=40 name=\"timage3\" value=\"$xti3\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Thumnail 4:<br></font>\n";
print "<input type=text size=40 name=\"timage4\" value=\"$xti4\"></p>\n";
print "</td></tr></table></td></tr>\n";
}
else
{
print "<td><tr>";
print "<input type=hidden name=\"fimage1\" value=\"$xfi1\">";
print "<input type=hidden name=\"fimage2\" value=\"$xfi2\">";
print "<input type=hidden name=\"fimage3\" value=\"$xfi3\">";
print "<input type=hidden name=\"fimage4\" value=\"$xfi4\">";
print "<input type=hidden name=\"timage1\" value=\"$xti1\">";
print "<input type=hidden name=\"timage2\" value=\"$xti2\">";
print "<input type=hidden name=\"timage3\" value=\"$xti3\">";
print "<input type=hidden name=\"timage4\" value=\"$xti4\">\n";
print "</td></tr>";
}
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Body:</b><br>(press return once to start a new line, press it twice to start a new paragraph)</font><br>\n";

#########################################
# NOW TURN <BR>s and %%s back into \n s
$body=~s/%%/\n\n/g;
$body=~s/<br>/\n/g;
#########################################

print "<textarea cols=65 rows=6 wrap=on name=\"content\">$body</textarea></td></tr>\n";
print << 'END'
<tr><TD width="100%" bgcolor="#A0BAD3"><p><FONT face="verdana, helvetica, arial" size="1"><b>Table (optional):</b><br>(a table can be used to present information such as dates or finances - to start a new cell use two colons (<b>::</b>), to create a new row start a new line by pressing return) For example:</font><br>
<pre>
su :: mo :: tu :: we :: th :: fr :: sa
   ::    ::    ::  1 ::  2 ::  3 ::  4
 5 ::  6 ::  7 ::  8 ::  9 :: 10 :: 11
12 :: 13 :: 14 :: 15 :: 16 :: 17 :: 18
19 :: 20 :: 21 :: 22 :: 23 :: 24 :: 25
26 :: 27 :: 28 :: 29 :: 30 :: 31 :: 
</pre>
<FONT face="verdana, helvetica, arial" size="1">(type &amp;nbsp; to render an empty cell)<br></font>
END
;

#$tbltext =~ s/%%/\n%%/g;

#########################################
# NOW TURN %%s back into \n s
$tbltext=~s/%%/\n/g;
#########################################

print "<textarea cols=65 rows=6 wrap=on name=\"tbltext\">$tbltext</textarea></td></tr>";
if($allowlinks eq "Y")
{
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>$rellinks</b><br>(Links to Related Pages and Sites)</font></p>\n";
print "<table width=\"75%\" cellpadding=2 cellspacing=2 border=0>\n";
print "<tr><td width=\"50%\" align=left valign=top>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 1 URL:<br></font>\n";
print "<input type=text size=40 name=\"usrlink1\" value=\"$ahref1\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 2 URL:<br></font>\n";
print "<input type=text size=40 name=\"usrlink2\" value=\"$ahref2\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 3 URL:<br></font>\n";
print "<input type=text size=40 name=\"usrlink3\" value=\"$ahref3\"></p>\n";
print "</td>\n";
print "<td width=\"50%\" align=left valign=top>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 1 name:<br></font>\n";
print "<input type=text size=40 name=\"linkname1\" value=\"$ahrefname1\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 2 name:<br></font>\n";
print "<input type=text size=40 name=\"linkname2\" value=\"$ahref2name\"></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\">Link 3 name:<br></font>\n";
print "<input type=text size=40 name=\"linkname3\" value=\"$ahref3name\"></p>\n";
print "</td></tr></table></td></tr>\n";
}
else
{
print "<td><tr>";
print "<input type=hidden name=\"usrlink1\" value=\"$ahref1\">";
print "<input type=hidden name=\"usrlink2\" value=\"$ahref2\">";
print "<input type=hidden name=\"usrlink3\" value=\"$ahref3\">";
print "<input type=hidden name=\"linkname1\" value=\"$ahrefname1\">";
print "<input type=hidden name=\"linkname2\" value=\"$ahref2name\">";
print "<input type=hidden name=\"linkname3\" value=\"$ahref3name\">\n";
print "</td></tr>";
}
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Text colour:</b><br>(sets the page text colour)</font><br>\n";
print "<input type=radio name=\"textc\" value=\"#000000\"";
    if ($textcolor eq "#000000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#000000\"><B>Black</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#800000\"";
    if ($textcolor eq "#800000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#800000\"><B>Maroon</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#ff0000\"";
    if ($textcolor eq "#ff0000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ff0000\"><B>Red</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#ffff00\"";
    if ($textcolor eq "#ffff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffff00\"><B>Yellow</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#00ff00\"";
    if ($textcolor eq "#00ff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#00ff00\"><B>Green</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#ffffff\"";
    if ($textcolor eq "#ffffff") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffffff\"><B>White</b></font>\n";
print "<input type=radio name=\"textc\" value=\"#0000ff\"";
    if ($textcolor eq "#0000ff") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#0000ff\"><B>Blue</b></font></p>\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Link colour:</b><br>(sets the link colour)</font><br>\n";
print "<input type=radio name=\"linkc\" value=\"#000000\"";
    if ($linkcolor eq "#000000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#000000\"><B>Black</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#800000\"";
    if ($linkcolor eq "#800000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#800000\"><B>Maroon</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#ff0000\"";
    if ($linkcolor eq "#ff0000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ff0000\"><B>Red</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#ffff00\"";
    if ($linkcolor eq "#ffff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffff00\"><B>Yellow</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#00ff00\"";
    if ($linkcolor eq "#00ff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#00ff00\"><B>Green</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#ffffff\"";
    if ($linkcolor eq "#ffffff") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffffff\"><B>White</b></font>\n";
print "<input type=radio name=\"linkc\" value=\"#0000ff\"";
    if ($linkcolor eq "#0000ff") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#0000ff\"><B>Blue</b></font></p>\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Visited link colour:</b><br>(sets the visited link colour)</font><br>\n";
print "<input type=radio name=\"vlinkc\" value=\"#000000\"";
    if ($vlinkcolor eq "#000000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#000000\"><B>Black</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#800000\"";
    if ($vlinkcolor eq "#800000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#800000\"><B>Maroon</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#ff0000\"";
    if ($vlinkcolor eq "#ff0000") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ff0000\"><B>Red</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#ffff00\"";
    if ($vlinkcolor eq "#ffff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffff00\"><B>Yellow</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#00ff00\"";
    if ($vlinkcolor eq "#00ff00") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#00ff00\"><B>Green</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#ffffff\"";
    if ($vlinkcolor eq "#ffffff") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#ffffff\"><B>White</b></font>\n";
print "<input type=radio name=\"vlinkc\" value=\"#0000ff\"";
    if ($vlinkcolor eq "#0000ff") {print " checked";}
    print "><FONT face=\"verdana, helvetica, arial\" size=\"1\" color=\"#0000ff\"><B>Blue</b></font></p>\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><B>Background:</b><br>(sets the appearance of the page background)</font></p>\n";
      opendir (TN, "$tnbg_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);
   $tnnum = @tnlist;
   $cnum = "0";
   print "<p><input type=radio name=\"background\" value=\"0\"";
   if (($bgimage eq "0")||($bgimage eq "")) { print " checked";}
   print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No background (selects browser default)</b></font></p>\n";
   while ($tnnum > $cnum) {
      print "<p><input type=radio name=\"background\" value=\"$tnbg_dir_url/$tnlist[$cnum]\"" ;
      if ($bgimage eq "$tnbg_dir_url/$tnlist[$cnum]") {print " checked";}
          print "><TABLE border=\"0\" width=\"100%\" background=\"$tnbg_dir_url/$tnlist[$cnum]\" height=\"50\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">&nbsp;</TD></TR></TABLE>\n";
      
#      print "><img src=\"$tnbg_dir_url/$tnlist[$cnum]\" border=1 ALT=\"$tnbg_dir_url/$tnlist[$cnum]\"></p>\n";
      $cnum = $cnum + 1;
      print "\n";
   }
print "</td></tr>";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>First horizontal line:</b><br>(sets the appearance of the first horizontal line)</font></p>\n";
      opendir (TN, "$tn_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";
      print "<p><input type=radio name=\"line\" value=\"0\"";
      if (($hrline eq "0")||($hrline eq "")) { print " checked";}
      print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No first line</b></font></p>\n";
   while ($tnnum > $cnum) {
      print "<p><input type=radio name=\"line\" value=\"$tn_dir_url/$tnlist[$cnum]\"";
      if ($hrline eq "$tn_dir_url/$tnlist[$cnum]") {print " checked";}
      print "><img src=\"$tn_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tn_dir_url/$tnlist[$cnum]\">\n";
      $cnum = $cnum + 1;
      print "</p>\n";
   }
 print "</td></tr>";   
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Second horizontal line:</b><br>(sets the appearance of the second horizontal line)</font></p>\n";
      opendir (TN, "$tn_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";
      print "<p><input type=radio name=\"anotherline\" value=\"0\"";
      if (($hrline2 eq "0")|| ($hrline2 eq "")) { print " checked";}
      print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No second line</b></font></p>\n";
   while ($tnnum > $cnum) {
      print "<p><input type=radio name=\"anotherline\" value=\"$tn_dir_url/$tnlist[$cnum]\"";
      if ($hrline2 eq "$tn_dir_url/$tnlist[$cnum]") {print " checked";}
      print "><img src=\"$tn_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tn_dir_url/$tnlist[$cnum]\">\n";
      $cnum = $cnum + 1;
      print "</p>\n";
   }
 print "</td></tr>";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Bullet:</b><br>(sets the appearance of bullets used to separate paragraphs of main body text)</font></p>\n";
      opendir (TN, "$tnb_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";
   print "<p><input type=radio name=\"bullet\" value=\"0\"";
   if(($bullet eq "0")||($bullet eq "")) {print " checked";}
   print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No bullet (all text will be centered)</b></font></p>\n";
   $lend = "0";   
while ($tnnum > $cnum) {
      print "<input type=radio name=\"bullet\" value=\"$tnb_dir_url/$tnlist[$cnum]\"";
      if ($bullet eq "$tnb_dir_url/$tnlist[$cnum]") {print " checked";}
      print "><img src=\"$tnb_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tnb_dir_url/$tnlist[$cnum]\">&nbsp;&nbsp;\n";
      $cnum = $cnum + 1;
    $lend = $lend + 1;
      if ($lend eq "10"){
    print "\n";
    $lend = 0;
    }
   }
  print "</td></tr>";

if($usecontactform eq "Y"){
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Contact Form Options:</b><br>(image for email link)</font></p>\n";

print "<p><input type=radio name=\"contactactive\" value=\"No\"";
   if(($contactactive eq "No")||($contactactive eq "")) {print " checked";}
 print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Do Not Use Contact Form</b></font></p>\n";
print "<p><input type=radio name=\"contactactive\" value=\"Yes\"";
if($contactactive eq "Yes") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Display Contact Form</b></font></p>\n";
   }
else
{
print "</td></tr>";
print "<TR><TD>";
print "<input type=hidden name=\"contactactive\" value=\"No\">";
print "</TR></TD>";
}

if($allowemail eq "Y"){
print "</td></tr>";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Email Options:</b><br></font></p>\n";
      opendir (TN, "$tne_dir");
      rewinddir (TN);
      @tnlist =  grep(!/^\.\.?$/, readdir (TN));
      closedir (TN);

   $tnnum = @tnlist;
   $cnum = "0";

print "<p><input type=radio name=\"emailonpage\" value=\"No\"";
   if($emailonpage eq "No") {print " checked";}
 print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Do Not Display Email Link</b></font></p>\n";
print "<p><input type=radio name=\"emailonpage\" value=\"Yes\"";
if($emailonpage ne "No") {print " checked";}
print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Display Email Link</b></font></p>\n";

print "<p><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Email Image Selection Options:</b><br></font></p>\n";

print "<p><input type=radio name=\"emailgif\" value=\"0\"";
   if(($emailpic eq "0")||($emailpic eq "")) {print " checked";}
   print "><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>No email image</b></font></p>\n";
   $lend = "0";
while ($tnnum > $cnum) {
      print "<input type=radio name=\"emailgif\" value=\"$tne_dir_url/$tnlist[$cnum]\"";
      if ($emailpic eq "$tne_dir_url/$tnlist[$cnum]") {print " checked";}
      print "><img src=\"$tne_dir_url/$tnlist[$cnum]\" border=0 ALT=\"$tne_dir_url/$tnlist[$cnum]\">\n";
      $cnum = $cnum + 1;
    $lend = $lend + 1;
      if ($lend eq "4"){
    print "\n";
    $lend = 0;
  }
   }
   }
else
{
print "<TR><TD>";
print "<input type=hidden name=\"emailonpage\" value=\"No\">";
print "<input type=hidden name=\"emailgif\" value=\"0\">";
print "</TR></TD>";

}
 }
sub error {
    local ($updact) = @_;
print "Content-type: text/html\n\n";
print "<html><head><title>Permission Denied</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Permission denied</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">You do not have permission! The Login information you entered is incorrect.</font></p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></center></DIV></body></html>\n";
exit;
    }
# Lost Login Information
sub lostlogin{

print "Content-type: text/html\n\n";
print "<html><head><title>Lost Login Information Request</title></head>\n";
print $badj_css;
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Lost Login Information Request</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Enter The Case Sensitive Page File Name With No Extension Or Path For Your Search</p>\n";
print "<form action=\"$cgiurl\" method=POST>\n";
print "<TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"5\"><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\">\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Name Of Your Page File Name:</b><br></font>\n";
print "<input type=text size=40 name=\"pagename\" value = \"\">\n";
print "</td></tr><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><input type=\"submit\" value=\"Search\">\n";
print "<input type=hidden name=\"action\" value=\"checkpages\">\n";
print "</FONT></td></form></tr></table>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
exit;
    }

sub checkpages{
$llir = 0;
open(FILE, "$data") || die "I can't open $data\n";  
if ($useflock) {
flock (FILE, 1) or die "can't lock data file\n";
}

    while(<FILE>) {
    chop;       
    @all = split(/\n/);

    foreach $line (@all) {
    ($loginname, $loginemail, $loginpagename) = split(/&&/, $line);
    if($loginpagename eq "$pagename") {
        $llir = 1;
        $gloem1 = "$loginpagename";   
        $gloem2 = "$loginemail";  
        $glouname = "$loginname"; 
          &SendLLIR($loginpagename);
        }
      }
    }

close(FILE);

if (! $llir) {
    &reqerror;
    }
      exit;
}
sub SendLLIR{
   
    local ($editfile) = @_;
    
    open(FILE, "$page_dir$editfile\.dat") || die "I can't open $editfile\n";
    if ($useflock) {
    flock (FILE, 1) or die "can't lock data file for edit\n";
    }

    while(<FILE>) {
    chop;
    @datafile = split(/\n/);

    foreach $line (@datafile) {
        &page_data_send($line);
            }
         }
    close(FILE);

    }


sub page_data_send($line) {
    local ($line) = @_;
    local($fullname, $mail, $head, $sub, $body, $bgimage, $linkcolor, $vlinkcolor, 
        $ahref1, $ahref2, $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4, $contactactive,
            $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos);

($fullname, $mail, $bgimage, $head, $sub, $body, $linkcolor, $vlinkcolor, $ahref1, $ahref2,
 $ahref3, $ahrefname1, $ahref2name, $ahref3name, $xfi1, $xfi2, $xfi3, $xfi4, $xti1, $xti2, $xti3, $xti4,  $contactactive, $filename, $imurl, $usecounter, $extpic, $timurl, $extthumb, $hrline, $emailpic, 
 $textcolor, $bullet, $tbltext, $font, $hrline2, $emailonpage, $headpos, $imagepos) = split(/&&/, $line);
         

 $glouemail = "$mail";
  open (MAIL, "| $sendmail -t") || die "I can't open sendmail\n";
  print MAIL "To: $glouemail\n";
  print MAIL "From: $myemail\n";
  print MAIL "Subject: Lost Login Information\n";
  print MAIL "\n";
  print MAIL "This Is The Login Data You Requested:\n";
  print MAIL "\n";
  print MAIL "Page: $gloem1\n";
  print MAIL "Login: $glouname\n";
  print MAIL "Original Email: $gloem2\n";
  print MAIL "\n";
  print MAIL "\nBest regards\n";
  print MAIL "\n$title\n";
  print MAIL "$baseurl\n";
&reqsent;
}
sub reqerror {
   
print "Content-type: text/html\n\n";
print "<html><head><title>Lost Login Data Request Status</title></head>\n";
print $badj_css;
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Request Failed</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Check The Case Sensitive Spelling For the Page With No Extension Or Path Information!</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
exit;
    }
# rename the below sub to reqsent for production
sub reqsent {
   
print "Content-type: text/html\n\n";
print "<html><head><title>Lost Login Data Request Status</title></head>\n";
print $badj_css;
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Information Sent</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Wait A Few Minutes Then Check Your Email Inbox For The Information You Requested!</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
exit;
    }
# rename the below sub to reqsent for demo purposes or delete it
sub demoreqsent {
   
print "Content-type: text/html\n\n";
print "<html><head><title>Lost Login Data Request Status</title></head>\n";
print $badj_css;
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Information Sent</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">\" Current Email:$glouemail Login: $glouname Original Email:$gloem2 Page FileName: $gloem1\"</p>\n";
print $badj_seperator;
print $badj_footer;
print "</td></tr></table></body></html>\n";
exit;
    }

# Upload Images
sub uploadimages{
if($allowuploads)
{
print "Content-type: text/html\n\n";
print "<html><head><title>Upload Login</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Login</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Enter your login name, e-mail address, and upload destination</b></font></p>\n";
print "<form action=\"$cgiurl\" method=POST>\n";
print "<TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"5\"><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\">\n";
print "<b>Login name:</b><br></font>\n";
print "<input size=40 type=password name=\"login\" value= \"\">\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>e-mail:</b><br></font>\n";
print "<input size=40 type=text name=\"email\" value= \"\"></td></tr>\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\"><b>Image Destination:</b></font>\n";
print "<SELECT NAME=uploadtype>\n";
if($thumbsup)
{
print "<OPTION SELECTED>Thumbnails\n"; 
}
if($picsup)
{
print "<OPTION>Pictures\n";
}
if($xthumbsup)
{
print "<OPTION>Extra Thumbnails \n";
}
if($xpicsup)
{
print "<OPTION>Extra Pictures\n";
}
if($backsup)
{
print "<OPTION>Backgrounds\n";
}
if($linesup)
{
print "<OPTION>Lines\n";
}
if($bulletsup)
{
print "<OPTION>Bullets\n";
}
if($emailsup)
{
print "<OPTION>Emails\n";
}
print "</SELECT>\n";

print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><input type=\"submit\" value=\"Login\">\n";
print "<input type=hidden name=\"action\" value=\"checkpriv\">\n";
print "</form></td></tr></table></table></DIV>\n";
print $badj_seperator;
print $badj_footer;
print $badj_seperator;
print "</td></tr>";
print "</body></html>\n";
exit;
    }
else
{
&error;
}
}

sub checkpriv{
$privmatch = 0;
if($adminuploads){
if($login eq $adminbd)
{
$privmatch = 1;
}
}
else
{
if($login eq $adminbd)
{
$adminupload = 1;
}

open(FILE, "$data") || die "I can't open $data\n";
if ($useflock) {
flock (FILE, 1) or die "can't lock data file\n";
}

    while(<FILE>) {
    chop;       
    @all = split(/\n/);

    foreach $line (@all) {
    ($loginname, $loginemail, $loginpagename) = split(/&&/, $line);
    if(($loginname eq "$login") && ($loginemail eq "$email")) {
        $privmatch = 1;
        }
      }
    }

close(FILE);
}
if (($privmatch)||($adminupload)) {
    &uploadtheimages;
        }
        else
        {
    &error;
        }
      exit;
}

sub uploadtheimages
{
if($uploadtype eq "Thumbnails")
{
$upldir = "$tnt_dir/";
}
if($uploadtype eq "Pictures")
{
$upldir = "$tnp_dir/";
}
if($uploadtype eq "Extra Thumbnails")
{
$upldir = "$tnxt_dir/";
}
if($uploadtype eq "Extra Pictures")
{
$upldir = "$tnxp_dir/";
}
if($uploadtype eq "Backgrounds")
{
$upldir = "$tnbg_dir/";
}
if($uploadtype eq "Lines")
{
$upldir = "$tn_dir/"; 
}
if($uploadtype eq "Bullets")
{
$upldir = "$tnb_dir/";
}
if($uploadtype eq "Emails")
{
$upldir = "$tne_dir/"; 
}



if(!privmatch){
&error;
}
else
{
print "Content-type: text/html\n\n";
print "<html><head><title>Image Upload</title>\n";
print $badj_css;
print "</head>";
print $badj_body;
print $badj_header;
print $badj_seperator;
print "<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">\n";
print "<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">\n";
print "Image Upload</font></p>\n";
print "<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Please Enter Or Select The Full Path Of Your Image To Upload</font></b></p>\n";
print "<form action=\"$uploadcgi\" method= \"POST\"  ENCTYPE=\"multipart/form-data\">\n";
print "<TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"5\"><TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><FONT face=\"verdana, helvetica, arial\" size=\"1\">\n";
print "<b>Image  1:</b><br></font>\n";
print "<input size=60 type=file name=\"uploaded_file\" value= \"\">\n";
print "</td></tr>\n";
print "<TR><TD width=\"100%\" bgcolor=\"#A0BAD3\"><input type=\"submit\" value=\"Upload!\">\n";
print "<input type=hidden name=\"directory\" value=\"$upldir\">\n";
print "</td></form></tr></table></table></DIV>\n";
print $badj_seperator;
print $badj_footer;
print $badj_seperator;
print "</td></tr>";
print "</body></html>\n";
exit;
}
}
